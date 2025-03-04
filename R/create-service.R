# publish an item to a feature layer
# https://developers.arcgis.com/rest/users-groups-and-items/publish-item.htm

# create a service
# https://developers.arcgis.com/rest/users-groups-and-items/create-service.htm


# TODO create with featureCollection which uses layers
# https://developers.arcgis.com/documentation/common-data-types/featurecollection.htm
# https://developers.arcgis.com/documentation/common-data-types/layer.htm

# IDEALLY we can create a layer with the field names and types etc already specified
# then we can use `add_features()` to add data in parallel. This will likely be much
# faster than uploading a file directly
# can theoretically publish a 0 element featureCollection with the field defs and then
# add_features()

#' Create a FeatureServer
#'
#' @param service_name
#' @param user default `Sys.getenv("ARCGIS_USER")`. Your account's username.
#' @param description default blank. The description of the feature server.
#' @param crs default `3857`. A coordinate reference system to set for the feature server.
#'  Must be compatible with `sf::st_crs()`.
#' @param capabilities default full capabilities. Character vector of capabilities.
#' @param query_formats default json and geojson. May be restricted by site-wide settings.
#' @param initial_extent optional. A named list with element of
#'  `xmin`, `xmax`, `ymin`, and `ymax`. Values must be in the same CRS as `crs`.
#' @param max_record_count default `1000`. The maximum number of records that can be
#'  retrieved from a layer in one request.
#' @param allow_updates default `TRUE`. Determine if geometries can be updated.
#' @param copyright default blank. Copyright notice to provide in the Feature Server
#' @param has_static_data default `FALSE`. Indicates if data is changing.
#' @param xss_prevention cross-site-scripting prevention is enabled by default.
#'   See details for more.
#'
#' @returns
#' If a `FeatureServer` is cerated successfully, a `FeatureServer` object is returned
#' based on the newly created feature server's url.
#'
#' @export
create_feature_server <- function(
    service_name,
    user = Sys.getenv("ARCGIS_USER"),
    description = "",
    crs = 3857,
    capabilities = c("create", "delete", "query", "update", "editing"),
    query_formats = c("json", "geojson"),
    initial_extent = list(xmin = NULL, xmax = NULL, ymin = NULL, ymax = NULL),
    max_record_count = 1000L,
    allow_updates = TRUE,
    copyright = "",
    has_static_data = FALSE,
    xss_prevention = xss_defaults(),
    host = "https://arcgis.com",
    token = Sys.getenv("ARCGIS_TOKEN")
) {

  match.arg(capabilities, several.ok = TRUE)
  # TODO add common parameters (such as tag and description)
  # https://developers.arcgis.com/rest/users-groups-and-items/common-parameters.htm

  # create the request url
  req_url <- paste0(host, "/sharing/rest/content/users/", user, "/createService")

  valid_crs <- validate_crs(crs)

  body <- compact(
    list(
      "name" = service_name,
      "serviceDescription" = description,
      "hasStaticData" = has_static_data,
      "maxRecordCount" = as.integer(max_record_count),
      "supportedQueryFormats" = paste0(tolower(query_formats), collapse = ","),
      "capabilities" =  paste0(tolower(capabilities), collapse = ","),
      "description" = "",
      "copyrightText" = "",
      "spatialReference" = valid_crs[["spatialReference"]],
      "initialExtent" = c(initial_extent, valid_crs),
      "allowGeometryUpdates" = allow_updates,
      "xssPreventionInfo" = xss_defaults()
    )
  )

  body_json <- jsonify::to_json(body, unbox = TRUE)

  req <- request(req_url)
  req <- req_url_query(
    req,
    outputType = "featureService",
    f = "json",
    token = token
  )

  req <- req_body_form(req, createParameters = jsonify::to_json(body, unbox = TRUE))

  resp <- req_perform(req)

  resp_parsed <- jsonify::from_json(resp_body_string(resp))

  detect_errors(resp_parsed)

  arc_open(resp_parsed[["encodedServiceURL"]])

}

xss_defaults <- function() {
  list(
    "xssPreventionEnabled" = TRUE,
    "xssPreventionRule" = "input",
    "xssInputRule" = "rejectInvalid"
  )
}

