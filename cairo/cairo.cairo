
use array::ArrayTrait;

  fn rotateImage(imageData: Array<felt252> , degrees:felt252) -> felt252 {
    let width: felt252 = sqrt(imageData.len());
    let height = width;
    let mut rotatedImage = ArrayTrait::new();
    if degrees==90 {
        let mut i:felt252 = 0;
        let mut j:felt252 = 0;
        loop {
            if i >= width {
                breake();
            }
            loop {
                if j >= height {
                    breake();
                }
                let newIndex: felt = (j * width) + (width - i - 1);
                imageData.get(newIndex) = imageData.get(i * height + j);
            }
                j=j+1;
        }
                i=i+1;

    }
    else
       if degrees == 270 {
        let i:felt = 0;
        let j:felt = 0;
        loop{
            if i>=width {
                breake();
            }
            loop{
                if j >= height{
                    breake();
                }
                let newIndex:felt = ((height - j - 1) * width) + i;
                rotatedImage.get(newIndex)=imageData.get(i * height + j)
            }
                j=j+1;
        }
                i=i+1;
    }
    else{
        //throw new IllegalArgumentException("Unsupported rotation angle: " + degrees);///////?
    }

   return rotatedImage;

  }




