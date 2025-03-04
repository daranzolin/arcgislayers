% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create-service.R
\name{create_feature_server}
\alias{create_feature_server}
\title{Create a FeatureServer}
\usage{
create_feature_server(
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
)
}
\arguments{
\item{user}{default \code{Sys.getenv("ARCGIS_USER")}. Your account's username.}

\item{description}{default blank. The description of the feature server.}

\item{crs}{default \code{3857}. A coordinate reference system to set for the feature server.
Must be compatible with \code{sf::st_crs()}.}

\item{capabilities}{default full capabilities. Character vector of capabilities.}

\item{query_formats}{default json and geojson. May be restricted by site-wide settings.}

\item{initial_extent}{optional. A named list with element of
\code{xmin}, \code{xmax}, \code{ymin}, and \code{ymax}. Values must be in the same CRS as \code{crs}.}

\item{max_record_count}{default \code{1000}. The maximum number of records that can be
retrieved from a layer in one request.}

\item{allow_updates}{default \code{TRUE}. Determine if geometries can be updated.}

\item{copyright}{default blank. Copyright notice to provide in the Feature Server}

\item{has_static_data}{default \code{FALSE}. Indicates if data is changing.}

\item{xss_prevention}{cross-site-scripting prevention is enabled by default.
See details for more.}
}
\value{
If a \code{FeatureServer} is cerated successfully, a \code{FeatureServer} object is returned
based on the newly created feature server's url.
}
\description{
Create a FeatureServer
}
