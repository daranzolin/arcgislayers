% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/arc-select.R
\name{arc_select}
\alias{arc_select}
\title{Retrieve a feature layer}
\usage{
arc_select(
  x,
  fields,
  where,
  crs = sf::st_crs(x),
  filter_geom,
  predicate = "intersects",
  n_max = Inf,
  ...
)
}
\arguments{
\item{x}{an object of class \code{FeatureLayer} or \code{Table}.}

\item{fields}{a character vector of the field names that you wish to be returned. By default all fields are returned.}

\item{crs}{the spatial reference to be returned. If the CRS is different than the \code{FeatureLayer}'s CRS, a transformation will occur server-side. Ignored for \code{Table} objects.}

\item{filter_geom}{an object of class \code{sfc} or \code{sfg} used to filter query results based on a predicate function. If an \code{sfc} object is provided it will be transformed to the layers spatial reference. If the \code{sfc} is missing a CRS (or is an \code{sfg} object) it is assumed to be in the layers spatial reference.}

\item{predicate}{default \code{"intersects"}. Possible options are \code{"intersects"},  \code{"contains"},  \code{"crosses"},  \code{"overlaps"},  \code{"touches"}, and \code{"within"}.}

\item{n_max}{the maximum number of features to return. By default returns every feature available. Unused at the moment.}

\item{...}{additional query parameters passed to the API. See \href{https://developers.arcgis.com/rest/services-reference/enterprise/query-feature-service-layer-.htm#GUID-BC2AD141-3386-49FB-AA09-FF341145F614}{reference documentation} for possible arguments.}
}
\description{
Give a \code{FeatureLayer} or \code{Table} object, retrieve its data as an \code{sf} object or \code{tibble} resepctively.
}
