## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

##this function uses makeVector and cachemean as a template and maps the structure of those onto a set of functions
##that returns the inverse of a matrix--makeCacheMatrix caches and cacheSolve pulls the inverse by calling it on an
##object with the makeCacheMatrix list of function outputs as its input

makeCacheMatrix <- function(x = matrix()) {
  inverse <- NULL
  set <- function(y) {
    x <<- y
    inverse <<- NULL
  }
  get <- function() x
  setinverse <- function(solve) inverse <<- solve
  getinverse <- function() inverse
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse)
}


## This function will retrieve the inverse cached by the
##makeCacheMatrix function above (inverse of matrix input x)

cacheSolve <- function(x, ...) {
  inverse <- x$getinverse()
  if(!is.null(inverse)) {
    message("getting cached data")
    return(inverse)
  }
  data <- x$get()
  inverse <- solve(data, ...)
  x$setinverse(inverse)
  inverse
}


#testing it
set.seed(42)
test_matrix <- matrix(rnorm(100), 10, 10)
test_matrix

solve(test_matrix)

makeCacheMatrix(test_matrix)
test <- makeCacheMatrix(test_matrix)

cacheSolve(x)
#it works!