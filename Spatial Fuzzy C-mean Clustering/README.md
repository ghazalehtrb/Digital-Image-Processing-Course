### Final Project - Spatial Fuzzy C-Means Clustering for Brain MRI Segmentation
FCM (fuzzy c-means clustering) is an unsupervised method used for image segmentation. It assigns a membership value to data points indicating the possibility of them belonging to each cluster. The original FCM is sensitive to noise, and a noisy pixel is classified incorrectly which is an important issue when it comes to medical applications such as MRI segmentation. To reduce the effect of noise, the authors of "[Fuzzy c-means clustering with spatial information for image segmentation](https://www-sciencedirect-com.lib-ezproxy.concordia.ca/science/article/pii/S0895611105000923)" proposed an altered version of FCM called sFCM (spatial FCM), by incorporating spatial information in the membership function. The idea behind this approach is the correlation of image pixels, meaning that pixels in the same neighborhood, most likely belong to the same clusters and the membership value of a noisy pixel can be corrected by considering the membership values of the neighboring pixels resulting in smoother and more homogenous segmentations.
Please refer "[Fuzzy c-means clustering with spatial information for image segmentation](https://www-sciencedirect-com.lib-ezproxy.concordia.ca/science/article/pii/S0895611105000923)"
to for more information.

<div align="center" style="width:image width px;">
  <img  src="https://github.com/ghazalehtrb/Digital-Image-Processing-Course/blob/e1769bec473351b5910fc66225eabf2fe9515970/Spatial%20Fuzzy%20C-mean%20Clustering/Capture.PNG?raw=true" width=400 alt="T1 and T2 weighted MRIs">
</div>
<p align="center">
<em>T1 and T2 weighted MRIs</em>
</p>

<div align="center" style="width:image width px;" >
  <img  src="https://github.com/ghazalehtrb/Digital-Image-Processing-Course/blob/79acf0e3516b24d5da7707d433b9d87a9e2842b5/Spatial%20Fuzzy%20C-mean%20Clustering/Picture2.png?raw=true" width=600 alt="sFCM on noisy MRIs vs MATLABs built-in FCM">
</div>
<p align="center">
<em>sFCM on noisy MRIs vs MATLABs built-in FCM</em>
</p>

## Implementation
This repository contains the implementation of sFCM in MATLAB. sFCM performs image segmentation by clustering points in n-dimensional feature space. The features used here are intensity values of T1-weighted and T2-weighted images. The image matrices are flattened and used as the first and second dimensions of the feature space. 

The controlling parameters of sFCM are 𝑚, controlling the level of fuzziness, the window size 𝑤, a threshold for convergence, the maximum iterations, and 𝑝 and 𝑞, controlling the relative importance of membership value of center pixel (𝑢) and the total membership value of the neighborhood (ℎ). sFCM then uses both of these values to compute the final membership value (𝑢′). Index 𝑖𝑗 shows the relation between pixel 𝑥𝑗 and cluster 𝑖 with 𝑣𝑖 as its center, 𝑁 is the number of points, 𝐶 is the number of clusters and 𝑁𝐵(𝑥𝑗) is the neighborhood of pixel 𝑥𝑗. Membership values, cluster centers, and spatial values are computed as follows:

<div align="center" style="width:image width px;" >
  <img  src="https://github.com/ghazalehtrb/Digital-Image-Processing-Course/blob/a80fa0fcc331161662c01023077b85692950c230/Spatial%20Fuzzy%20C-mean%20Clustering/eq.PNG?raw=true" width=600 alt="equations">
</div>




