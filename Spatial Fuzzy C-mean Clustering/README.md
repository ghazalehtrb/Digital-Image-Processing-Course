### Final Project - Spatial Fuzzy C-Means Clustering for Brain MRI Segmentation
FCM (fuzzy c-means clustering) is an unsupervised method used for image segmentation. It assigns a membership value to data points indicating the possibility of them belonging to each cluster. The original FCM is sensitive to noise, and a noisy pixel is classified incorrectly which is an important issue when it comes to medical applications such as MRI segmentation. To reduce the effect of noise, the authors of "[Fuzzy c-means clustering with spatial information for image segmentation](https://www-sciencedirect-com.lib-ezproxy.concordia.ca/science/article/pii/S0895611105000923)" proposed an altered version of FCM called sFCM (spatial FCM), by incorporating spatial information in the membership function. The idea behind this approach is the correlation of image pixels, meaning that pixels in the same neighborhood, most likely belong to the same clusters and the membership value of a noisy pixel can be corrected by considering the membership values of the neighboring pixels resulting in smoother and more homogenous segmentations.
Please refer "[Fuzzy c-means clustering with spatial information for image segmentation](https://www-sciencedirect-com.lib-ezproxy.concordia.ca/science/article/pii/S0895611105000923)"
to for more information.

<br/>

<br/>
<div align="center" style="width:image width px;">
  <img  src="https://github.com/ghazalehtrb/Digital-Image-Processing-Course/blob/master/Spatial%20Fuzzy%20C-mean%20Clustering/Capture.PNG" alt="T1 and T2 weighted MRIs">
</div>



