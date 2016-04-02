# Author:tnybny
# this file visualizes 5 random handwritten digits and labels

# reverses (rotates the matrix) 90 degrees clockwise
rotate <- function(x) t(apply(x, 2, rev))

# unwrap 5 random examples and display them along with their label
viz <- function(X, Y)
{
    samp <- sample(1:nrow(X), size = 5, replace = FALSE)
    for(i in samp)
    {
        digit = rotate(matrix(unlist(X[i, ]), nrow = 28, ncol = 28,
                              byrow = TRUE))
        graphics::image(digit, col = grey.colors(255), asp = 1,
                        main = paste(Y[i]))
    }
}