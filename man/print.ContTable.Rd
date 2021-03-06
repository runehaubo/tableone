% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/print.ContTable.R
\name{print.ContTable}
\alias{print.ContTable}
\title{Format and print \code{ContTable} class objects}
\usage{
\method{print}{ContTable}(x, digits = 2, pDigits = 3, quote = FALSE,
  missing = FALSE, explain = TRUE, printToggle = TRUE, noSpaces = FALSE,
  nonnormal = NULL, minMax = FALSE, insertLevel = FALSE, test = TRUE,
  smd = FALSE, ...)
}
\arguments{
\item{x}{Object returned by \code{\link{CreateContTable}} function.}

\item{digits}{Number of digits to print in the table.}

\item{pDigits}{Number of digits to print for p-values (also used for standardized mean differences).}

\item{quote}{Whether to show everything in quotes. The default is FALSE. If TRUE, everything including the row and column names are quoted so that you can copy it to Excel easily.}

\item{missing}{Whether to show missing data information.}

\item{explain}{Whether to add explanation to the variable names, i.e., (mean (sd) or median [IQR]) is added to the variable names.}

\item{printToggle}{Whether to print the output. If FALSE, no output is created, and a matrix is invisibly returned.}

\item{noSpaces}{Whether to remove spaces added for alignment. Use this option if you prefer to align numbers yourself in other software.}

\item{nonnormal}{A character vector to specify the variables for which the p-values should be those of nonparametric tests. By default all p-values are from normal assumption-based tests (oneway.test).}

\item{minMax}{Whether to use [min,max] instead of [p25,p75] for nonnormal variables. The default is FALSE.}

\item{insertLevel}{Whether to add an empty level column to the left of strata.}

\item{test}{Whether to show p-values. TRUE by default. If FALSE, only the numerical summaries are shown.}

\item{smd}{Whether to show standardized mean differences. FALSE by default. If there are more than one contrasts, the average of all possible standardized mean differences is shown. For individual contrasts, use \code{summary}.}

\item{...}{For compatibility with generic. Ignored.}
}
\value{
A matrix object containing what you see is also invisibly returned. This can be assinged a name and exported via \code{write.csv}.
}
\description{
\code{print} method for the \code{ContTable} class objects created by \code{\link{CreateContTable}} function.
}
\examples{

## Load
library(tableone)

## Load Mayo Clinic Primary Biliary Cirrhosis Data
library(survival)
data(pbc)
## Check variables
head(pbc)

## Create an overall table for continuous variables
contVars <- c("time","age","bili","chol","albumin","copper",
              "alk.phos","ast","trig","platelet","protime")
contTableOverall <- CreateContTable(vars = contVars, data = pbc)

## Simply typing the object name will invoke the print.ContTable method,
## which will show the sample size, means and standard deviations.
contTableOverall

## To further examine the variables, use the summary.ContTable method,
## which will show more details.
summary(contTableOverall)

## c("age","chol","copper","alk.phos","trig","protime") appear highly skewed.
## Specify them in the nonnormal argument, and the display changes to the median,
## and the [25th, 75th] percentile.
nonNormalVars <- c("age","chol","copper","alk.phos","trig","protime")
print(contTableOverall, nonnormal = nonNormalVars)

## To show median [min,max] for nonnormal variables, use minMax = TRUE
print(contTableOverall, nonnormal = nonNormalVars, minMax = TRUE)

## The table can be stratified by one or more variables
contTableBySexTrt <- CreateContTable(vars = contVars,
                                     strata = c("sex","trt"), data = pbc)

## print now includes p-values which are by default calculated by oneway.test (t-test
## equivalent in the two group case). It is formatted at the decimal place specified
## by the pDigits argument (3 by default). It does <0.001 for you.
contTableBySexTrt

## The nonnormal argument toggles the p-values to the nonparametric result from
## kruskal.test (wilcox.test equivalent for the two group case).
print(contTableBySexTrt, nonnormal = nonNormalVars)

## The minMax argument toggles whether to show median [range]
print(contTableBySexTrt, nonnormal = nonNormalVars, minMax = TRUE)

## summary now includes both types of p-values
summary(contTableBySexTrt)

## If your work flow includes copying to Excel and Word when writing manuscripts,
## you may benefit from the quote argument. This will quote everything so that
## Excel does not mess up the cells.
print(contTableBySexTrt, nonnormal = nonNormalVars, quote = TRUE)

## If you want to center-align values in Word, use noSpaces option.
print(contTableBySexTrt, nonnormal = nonNormalVars, quote = TRUE, noSpaces = TRUE)

}
\seealso{
\code{\link{CreateTableOne}}, \code{\link{CreateContTable}}, \code{\link{summary.ContTable}}
}
\author{
Kazuki Yoshida
}
