package.skeleton( 
  
  name = "cuteMatrix", # name of the package that will be created 
  
  path = "C:/Users/yhan/Documents/Git_projects/cuteMatrix", # where the package will be created 
  
  # list = c("fun_check", "fun_secu", "fun_report","fun_get_message","fun_pack"), # if the functions are in the global environement (controled by environement argument) 
  
  code_files = c( 
    "C:/Users/yhan/Documents/Git_projects/cuteMatrix/internal_functions.R",
    "C:/Users/yhan/Documents/Git_projects/cuteMatrix/mat_fill.R",
    "C:/Users/yhan/Documents/Git_projects/cuteMatrix/mat_inv.R",
    "C:/Users/yhan/Documents/Git_projects/cuteMatrix/mat_num2color.R",
    "C:/Users/yhan/Documents/Git_projects/cuteMatrix/mat_op.R",
    "C:/Users/yhan/Documents/Git_projects/cuteMatrix/mat_rotate.R"
  ) # path where .R files are, if the functions are in a .R files (that will be sourced) 
)
