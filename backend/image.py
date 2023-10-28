import pytesseract as tess

from PIL import Image
import PIL

image1 = "backend/Prescriptions/1c.jpg"
image3 = "backend/Prescriptions/3c.jpg"
image4 = "backend/Prescriptions/4c.png"



def process_prescription(image): #returns [[True if need dose during that part], drug name, dosage, info]
    im = Image.open(image)

    width, height = im.size

    imDoseChartComplete = im.crop((.13*width, 0, .29*width, .59*height)).rotate(90, PIL.Image.NEAREST, expand = 1)

    imDoseChart1 = im.crop((.13*width, 0, .29*width, .16*height))
    imDoseChart2 = im.crop((.13*width, .16*height, .29*width, .33*height))
    imDoseChart3 = im.crop((.13*width, .32*height, .29*width, .46*height))
    imDoseChart4 = im.crop((.13*width, .46*height, .29*width, .59*height))

    imName = im.crop((.29*width, 0, width, .205*height))
    imDoseText = im.crop((.29*width, .19*height, width, .48*height))
    imImportantInfo = im.crop((.29*width, .48*height, width, height))

    name = tess.image_to_string(imName)
    dosage = tess.image_to_string(imDoseText)
    info = tess.image_to_string(imImportantInfo)

    if("SEE" in tess.image_to_string(imDoseChartComplete)):
        return ([False, False, False, False], name, dosage, info)
    else:
        dose_times = [tess.image_to_string(imDoseChart1), tess.image_to_string(imDoseChart2), tess.image_to_string(imDoseChart3), tess.image_to_string(imDoseChart4)]
        dose_times = [True if len(dose_time) != 0 else False for dose_time in dose_times]
        return (dose_times, name, dosage, info)


print(process_prescription(image4))
