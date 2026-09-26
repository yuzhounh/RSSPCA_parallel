# Robust Sparse Smooth Principal Component Analysis (RSSPCA) - Parallel Implementation

Parallel MATLAB experiments for robust sparse smooth PCA in face reconstruction and recognition.

[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-D4AF37?style=flat-square)](LICENSE)

RSSPCA is a novel dimensionality reduction method combining robustness, sparsity and smoothness properties for face reconstruction and recognition tasks. The algorithm solves the following optimization problem:

$$\mathop{\max}_{w}\lVert X^Tw\rVert_1,  s.t. \lVert w\rVert_2^2=1,  \lVert w\rVert_1<=c_1, w^TLw<=c_2$$

where $c_1$ and $c_2$ are positive constants, and $L$ is a Laplacian matrix representing the two-dimensional spatial structure information of images.

The algorithm combines robustness (for outliers/noise resistance), sparsity (for feature selection), and smoothness (for spatial relationship preservation). It has been validated on six benchmark face databases (AR, FEI, FERET, GT, ORL, Yale) against methods including PCA, PCA-L1, RSPCA, and RSMPCA.

To run the demo, execute `main.m` in MATLAB. This is the parallel computing implementation of RSSPCA, designed to improve performance for large-scale face reconstruction and recognition tasks. The original sequential implementation is available at [RSSPCA](https://github.com/yuzhounh/RSSPCA). Additional benchmark face databases can be found [here](https://github.com/yuzhounh/Face-databases).

## Prerequisites and Execution

Use MATLAB with Parallel Computing Toolbox. Before running [main.m](main.m), supply `data/FEI.mat`: [split_data.m](split_data.m) explicitly loads six datasets, while the tracked [data/](data/) directory contains AR, Feret, GT, ORL, and Yale but no FEI matrix. Use the [Face-databases collection](https://github.com/yuzhounh/Face-databases) already linked by the original documentation to prepare the required input.

Review [para_workers.m](para_workers.m) and worker counts for your hardware. Once the configured inputs are available, run `main` from the repository directory. It prepares Laplacian matrices and noisy inputs, runs reconstruction, creates training/test splits, runs classification, and analyzes the outputs.

## Repository Structure

- [main.m](main.m): experiment workflow.
- [split_data.m](split_data.m): repeated train/test splits.
- `reco_*_parallel.m` and `classify_*_parallel.m`: parallel drivers.
- [para_workers.m](para_workers.m): pool configuration.
- [data/](data/): five currently included dataset matrices.

## Citation

If you use this code, please cite our paper:
```bibtex
@article{wang2025robust,
author = {Jing Wang and Xiao Xie and Li Zhang and Jian Li and Hao Cai and Yan Feng},
title = {Robust sparse smooth principal component analysis for face reconstruction and recognition},
journal = {PLOS ONE},
year = {2025},
volume = {20},
number = {5},
pages = {e0323281},
doi = {10.1371/journal.pone.0323281}
}
```

## License

See the existing [GPL-3.0 license](LICENSE).

## Contact

Jing Wang (wangjing@xynu.edu.cn)
