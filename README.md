# Robust Sparse Smooth Principal Component Analysis (RSSPCA) - Parallel Implementation

[![License](https://img.shields.io/badge/License-BSD-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

This repository contains the parallel computing implementation of Robust Sparse Smooth Principal Component Analysis (RSSPCA) for face reconstruction and recognition tasks.

## Overview

RSSPCA finds the first projection vector by solving the following optimization problem:

$$\mathop{\max}_{w}||X^Tw||_1,  s.t. ||w||_2^2=1,  ||w||_1<=c_1,  w^TLw<=c_2$$

where:
- $c_1$ and $c_2$ are positive constants
- $L$ is a Laplacian matrix representing the two-dimensional spatial structure information of images

## Features

- Parallel computing implementation for improved performance
- Robust to outliers and noise in face images
- Sparse projection vectors for efficient feature extraction
- Incorporates spatial smoothness constraints
- Suitable for large-scale face reconstruction and recognition tasks

## Experimental Validation

The algorithm was extensively evaluated on six benchmark face databases:
- AR
- FEI  
- FERET
- GT
- ORL
- Yale

More benchmark face databases can be found [here](https://github.com/yuzhounh/Face-databases).

### Comparison Methods
RSSPCA was compared with several state-of-the-art algorithms:
- PCA (Principal Component Analysis)
- PCA-L1 
- RSPCA
- RSMPCA

## Installation and Usage

1. Clone this repository:
```bash
git clone https://github.com/username/RSSPCA_2.git
```

2. Run the demo script in MATLAB:
```matlab
main.m
```

## Related Projects

- [RSSPCA](https://github.com/yuzhounh/RSSPCA): The original sequential implementation of this algorithm

## Contact

**Jing Wang**
- Email: wangjing@xynu.edu.cn

## License

Copyright (C) 2023 Jing Wang. This code is released under the BSD license.

## Updates

Last updated: January 29, 2024
