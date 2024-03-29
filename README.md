# `Everything` File Search in the Terminal

通过调用`Everything` HTTP API实现在命令行搜索文件，具体代码见[e.R](e.R)。

这也是如何将R语言打造成脚本语言的一个案例。

## Example

```powershell
e "class CUG hydroMet"
# [1] "C:/Users/hydro/github/class2022_CUG_HydroMet"
# [2] "D:/Documents/OneDrive/水文气象学/class2022_CUG_HydroMet"
# [3] "E:/0-教学课件/class2023_CUG_HydroMet"
# [4] "X:/rpkgs/hydroTools.R/scripts/class_CUG_HydroMet" 
```

```powershell
e BEPS.jl
# [1] "Z:/GitHub/cug-hydro/BEPS.jl"
# [2] "Z:/GitHub/cug-hydro/BEPS.jl/src/BEPS.jl"
# [3] "Z:/DATA/Soil Moisture(2018-2022)/scripts/s2_BEPS.jl"
```

## Requirements

- R (>= 4.2.0)
- R packages: `httr`, `rvest` and `dplyr`
