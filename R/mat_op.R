#' @title mat_op
#' @description
#' Assemble several matrices of same dimensions by performing by case operation. For instance, with kind.of.operation = "+", the function will add the value of all the case 1 (row1 & column1) of the matrices and put it in the case 1 of a new matrix M, according to the formula
#' 
#' \deqn{c_{ij} = \sum_{k=1}^{k=z}c_{ijk}}
#' c: case
#' 
#' i: row number
#' 
#' j: column number
#' 
#' k: matrix number
#' 
#' z: number of matrices
#' @param mat.list List of matrices.
#' @param kind.of.operation Either "+" (by case addition), "-" (by case subtraction) or "*" (by case multiplication).
#' @returns The assembled matrix, with row and/or column names only if all the matrices have identical row/column names.
#' @details
#' REQUIRED PACKAGES
#' 
#' cuteDev
#' 
#' cuteTool
#' 
#' REQUIRED FUNCTIONS FROM THE cute PACKAGE
#' 
#' arg_check()
#' 
#' comp_2d()
#' 
#' @examples
#' mat1 = matrix(c(1,1,1,2,1,5,9,8), ncol = 2) ; 
#' mat2 = matrix(c(1,1,1,2,1,5,9,NA), ncol = 2) ; 
#' mat_op(mat.list = list(mat1, mat2), kind.of.operation = "+")
#' 
#' mat1 = matrix(c(1,1,1,2,1,5,9,8), ncol = 2, dimnames = list(LETTERS[1:4], letters[1:2])) ; 
#' mat2 = matrix(c(1,1,1,2,1,5,9,NA), ncol = 2, dimnames = list(LETTERS[1:4], letters[1:2])) ; 
#' mat_op(mat.list = list(mat1, mat2), kind.of.operation = "*")
#' 
#' mat1 = matrix(c(1,1,1,2,1,5,9,8), ncol = 2, dimnames = list(LETTERS[1:4], c(NA, NA))) ; 
#' mat2 = matrix(c(1,1,1,2,1,5,9,NA), ncol = 2, dimnames = list(LETTERS[1:4], letters[1:2])) ; 
#' mat_op(mat.list = list(mat1, mat2), kind.of.operation = "-")
#' 
#' mat1 = matrix(c(1,1,1,2,1,5,9,8), ncol = 2, dimnames = list(c("A1", "A2", "A3", "A4"), letters[1:2])) ; 
#' mat2 = matrix(c(1,1,1,2,1,5,9,NA), ncol = 2, dimnames = list(LETTERS[1:4], letters[1:2])) ; 
#' mat3 = matrix(c(1,1,1,2,1,5,9,NA), ncol = 2, dimnames = list(LETTERS[1:4], letters[1:2])) ; 
#' mat_op(mat.list = list(mat1, mat2, mat3), kind.of.operation = "+")
#' @importFrom cuteDev arg_check
#' @importFrom cuteTool comp_2d
#' @export
mat_op <- function(
        mat.list, 
        kind.of.operation = "+"
){
    # DEBUGGING
    # mat1 = matrix(c(1,1,1,2,1,5,9,8), ncol = 2) ; mat2 = matrix(c(1,1,1,2,1,5,9,NA), ncol = 2) ; mat.list = list(mat1, mat2) ; kind.of.operation = "+" # for function debugging
    # mat1 = matrix(c(1,1,1,2,1,5,9,8), ncol = 2, dimnames = list(LETTERS[1:4], c(NA, NA))) ; mat2 = matrix(c(1,1,1,2,1,5,9,NA), ncol = 2, dimnames = list(LETTERS[1:4], letters[1:2])) ; mat.list = list(mat1, mat2) ; kind.of.operation = "*" # for function debugging
    # package name
    package.name <- "cuteMatrix"
    # end package name
    # function name
    ini <- match.call(expand.dots = FALSE) # initial parameters (specific of arg_test())
    function.name <- paste0(as.list(match.call(expand.dots = FALSE))[[1]], "()") # function name with "()" paste, which split into a vector of three: c("::()", "package()", "function()") if "package::function()" is used.
    if(function.name[1] == "::()"){
        function.name <- function.name[3]
    }
    arg.names <- names(formals(fun = sys.function(sys.parent(n = 2)))) # names of all the arguments
    arg.user.setting <- as.list(match.call(expand.dots = FALSE))[-1] # list of the argument settings (excluding default values not provided by the user)
    # end function name
    # package checking
    # check of lib.path
    # end check of lib.path
    
    # check of the required function from the required packages
    .pack_and_function_check(
        fun = c(
            "cuteDev::arg_check",
            "cuteTool::comp_2d"
        ),
        lib.path = NULL,
        external.function.name = function.name
    )
    # end check of the required function from the required packages
    # end package checking

    # argument primary checking
    # arg with no default values
    mandat.args <- c(
        "mat.list"
    )
    tempo <- eval(parse(text = paste0("missing(", paste0(mandat.args, collapse = ") | missing("), ")")))
    if(any(tempo)){ # normally no NA for missing() output
        tempo.cat <- paste0("ERROR IN ", function.name, " OF THE ", package.name, " PACKAGE: \nFOLLOWING ARGUMENT", ifelse(sum(tempo, na.rm = TRUE) > 1, "S HAVE", "HAS"), " NO DEFAULT VALUE AND REQUIRE ONE:\n", paste0(mandat.args, collapse = "\n"))
        stop(paste0("\n\n================\n\n", tempo.cat, "\n\n================\n\n"), call. = FALSE) # == in stop() to be able to add several messages between ==
    }
    # end arg with no default values
    
    # argument checking with cuteDev::arg_check()
    argum.check <- NULL #
    text.check <- NULL #
    checked.arg.names <- NULL # for function debbuging: used by r_debugging_tools
    ee <- expression(argum.check = c(argum.check, tempo$problem) , text.check = c(text.check, tempo$text) , checked.arg.names = c(checked.arg.names, tempo$object.name))
    tempo <- cuteDev::arg_check(data = mat.list, class = "list", fun.name = function.name) ; eval(ee)
    tempo <- cuteDev::arg_check(data = kind.of.operation, options = c("+", "-", "*"), length = 1, fun.name = function.name) ; eval(ee)
    if( ! is.null(argum.check)){
        if(any(argum.check, na.rm = TRUE) == TRUE){
            stop(paste0("\n\n================\n\n", paste(text.check[argum.check], collapse = "\n"), "\n\n================\n\n"), call. = FALSE) #
        }
    }
    # end argument checking with cuteDev::arg_check()
    
    # check with r_debugging_tools
    # source("C:/Users/yhan/Documents/Git_projects/debugging_tools_for_r_dev/r_debugging_tools.R") ; eval(parse(text = str_basic_arg_check_dev)) ; eval(parse(text = str_arg_check_with_fun_check_dev)) # activate this line and use the function (with no arguments left as NULL) to check arguments status and if they have been checked using cuteDev::arg_check()
    # check with r_debugging_tools
    # end argument primary checking
    
    # second round of checking and data preparation
    # management of NA arguments
    if( ! (all(class(arg.user.setting) == "list", na.rm = TRUE) & length(arg.user.setting) == 0)){
        tempo.arg <- names(arg.user.setting) # values provided by the user
        tempo.log <- suppressWarnings(sapply(lapply(lapply(tempo.arg, FUN = get, env = sys.nframe(), inherit = FALSE), FUN = is.na), FUN = any)) & lapply(lapply(tempo.arg, FUN = get, env = sys.nframe(), inherit = FALSE), FUN = length) == 1L # no argument provided by the user can be just NA
        if(any(tempo.log) == TRUE){ # normally no NA because is.na() used here
            tempo.cat <- paste0("ERROR IN ", function.name, " OF THE ", package.name, " PACKAGE: \n", ifelse(sum(tempo.log, na.rm = TRUE) > 1, "THESE ARGUMENTS", "THIS ARGUMENT"), " CANNOT JUST BE NA:", paste0(tempo.arg[tempo.log], collapse = "\n"))
            stop(paste0("\n\n================\n\n", tempo.cat, "\n\n================\n\n"), call. = FALSE) # == in stop() to be able to add several messages between ==
        }
    }
    # end management of NA arguments
    
    # management of NULL arguments
    tempo.arg <-c(
        "mat.list",
        "kind.of.operation"
    )
    tempo.log <- sapply(lapply(tempo.arg, FUN = get, env = sys.nframe(), inherit = FALSE), FUN = is.null)
    if(any(tempo.log) == TRUE){# normally no NA with is.null()
        tempo.cat <- paste0("ERROR IN ", function.name, " OF THE ", package.name, " PACKAGE:\n", ifelse(sum(tempo.log, na.rm = TRUE) > 1, "THESE ARGUMENTS\n", "THIS ARGUMENT\n"), paste0(tempo.arg[tempo.log], collapse = "\n"),"\nCANNOT BE NULL")
        stop(paste0("\n\n================\n\n", tempo.cat, "\n\n================\n\n"), call. = FALSE) # == in stop() to be able to add several messages between ==
    }
    # end management of NULL arguments
    
    # code that protects set.seed() in the global environment
    # end code that protects set.seed() in the global environment
    
    # warning initiation
    # end warning initiation
    
    # other checkings
    # argument checking without cuteDev::arg_check()
    if(length(mat.list) < 2){
        tempo.cat <- paste0("ERROR IN ", function.name, " OF THE ", package.name, " PACKAGE: mat.list ARGUMENT MUST BE A LIST CONTAINING AT LEAST 2 MATRICES")
        stop(paste0("\n\n================\n\n", tempo.cat, "\n\n================\n\n"), call. = FALSE) # == in stop() to be able to add several messages between ==
    }
    for(i1 in 1:length(mat.list)){
        tempo <- cuteDev::arg_check(data = mat.list[[i1]], class = "matrix", mode = "numeric", na.contain = TRUE)
        if(tempo$problem == TRUE){
            tempo.cat <- paste0("ERROR IN ", function.name, " OF THE ", package.name, " PACKAGE: ELEMENT ", i1, " OF mat.list ARGUMENT MUST BE A NUMERIC MATRIX")
            stop(paste0("\n\n================\n\n", tempo.cat, "\n\n================\n\n"), call. = FALSE) # == in stop() to be able to add several messages between ==
        }
    }
    ident.row.names <- TRUE
    ident.col.names <- TRUE
    for(i1 in 2:length(mat.list)){
        tempo <- cuteTool::comp_2d(data1 = mat.list[[1]], data2 = mat.list[[i1]])
        if(tempo$same.dim == FALSE){
            tempo.cat <- paste0("ERROR IN ", function.name, " OF THE ", package.name, " PACKAGE: MATRIX ", i1, " OF mat.list ARGUMENT MUST HAVE THE SAME DIMENSION (", paste(dim(mat.list[[i1]]), collapse = " "), ") THAN THE MATRIX 1 IN mat.list (", paste(dim(mat.list[[1]]), collapse = " "), ")")
            stop(paste0("\n\n================\n\n", tempo.cat, "\n\n================\n\n"), call. = FALSE) # == in stop() to be able to add several messages between ==
        }
        if( ! is.null(tempo$same.row.name)){
            if(tempo$same.row.name != TRUE){ # != TRUE to deal with NA
                ident.row.names <- FALSE
            }
        }
        if( ! is.null(tempo$same.col.name)){
            if(tempo$same.col.name != TRUE){ # != TRUE to deal with NA
                ident.col.names <- FALSE
            }
        }
    }
    # end argument checking without cuteDev::arg_check()
    # end other checkings
    
    # reserved words (to avoid bugs)
    # end reserved words (to avoid bugs)
    # end second round of checking and data preparation
    
    # main code
    # output
    # warning output
    # end warning output
    output <- mat.list[[1]]
    for(i1 in 2:length(mat.list)){
        output <- get(kind.of.operation)(output, mat.list[[i1]]) # no env = sys.nframe(), inherit = FALSE in get() because look for function in the classical scope
    }
    dimnames(output) <- NULL
    if(ident.row.names == TRUE){
        rownames(output) <- rownames(mat.list[[1]])
    }
    if(ident.col.names == TRUE){
        colnames(output) <- colnames(mat.list[[1]])
    }
    return(output)
    # end output
    # end main code
}
