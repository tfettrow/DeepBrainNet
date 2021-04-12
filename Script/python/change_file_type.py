# https://stackoverflow.com/questions/44397617/change-data-type-in-numpy-and-nibabel/45589431
import nibabel as nib
import numpy as np

image = nib.load('../MiM_Data/Subject3_T1_BrainAligned.nii.gz')

# to be extra sure of not overwriting data:
new_data = np.copy(image.get_fdata())
hd = image.header

# update data type:
new_dtype = np.uint16  # for example to cast to int8.
new_data = new_data.astype(new_dtype)
image.set_data_dtype(new_dtype)

# im = Image.fromarray((x * 255).astype(np.uint8)) https://stackoverflow.com/questions/55319949/pil-typeerror-cannot-handle-this-data-type


# if nifty1
if hd['sizeof_hdr'] == 348:
    new_image = nib.Nifti1Image(new_data, image.affine, header=hd)
# if nifty2
elif hd['sizeof_hdr'] == 540:
    new_image = nib.Nifti2Image(new_data, image.affine, header=hd)
else:
    raise IOError('Input image header problem')

nib.save(new_image, '../MiM_Data/Subject3_T1_BrainAligned.nii.gz')