# CubicSpline
# Language: R
# Input: TXT (parameters)
# Output: CSV (splines)
# Tested with: PluMA 1.1, R 4.0.0
# Dependency: graphics_4.0.0

PluMA plugin to run cubic spline interpolation.  For flexibility with respect
to machine learning, CubicSpline merges a "clinical" and a "training" set for
input values.  It then performs spline interpolation for each unique subject.

Both input files (training and clinical) are assumed to be in TSV (tab-separated value)
format, with rows corresponding to subjects and columns corresponding to feature values.
The input for the plugin is a TXT file of keyword-value pairs, training and clinical,
each mapping to their respective filenames.

The plugin will output a CSV file of x-y coordinates for the splines, one set per
subject.  It also produces the standard Rplots.pdf file for the spline graphs.

Note the input TSV files in the example/ directory are not publically available.
A future goal is to make a synthetic data set.  In the meantime however, one may 
use it on their own tab-separated input data.
