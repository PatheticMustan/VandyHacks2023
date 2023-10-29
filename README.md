## Inspiration
As stated by the National Library of Medicine and the Patient Safety presentation, medication error is the most common error in healthcare, and it particularly affects for elders who commonly mistakenly take an incorrect frequency, dosage, or omission of taking their prescription drugs, resulting in avoidable deaths. Although elders may be the largest group with this issue, people with vision impairment, mental disabilities, and even nursing homes can also clearly benefit from a more robust way to keep track of medication frequency and dosage than just the physical paper prescription you get from your doctor. Thus, we created RxScanner, a simple app that allows the user to scan their prescription and automatically upload their drugs' administration schedule, dosage per administration, and important information/instructions on their drug to Google Calendar.

## What it does
RxScanner is a mobile app that allows you to use your phone camera to scan physical prescriptions you get from the pharmacy, allowing an easier and more accessible way to read the prescriptions. The app then automatically image processes the prescription image into the drug's name, administration schedule, dosage, and other information/instructions and save this information to their google calendar, which could help the elderly/mentally impaired remember and keep up with their dosage schedule. A larger use for this app would be elderly homes using this to keep track of all of their patient's drug administration schedules. 

## How we built it
For the frontend, we developed the mobile app using Flutter, allowing us to access the devices camera and scan the prescription. This then connects to the Python rest API backend, coded using Flask, which does the image processing and parsing of prescription data according to a standard CVS prescription layout. We host this Python backend on a Google Cloud VPS for reliable access and also host the rest API on a .tech domain (prescriptionscanner.tech). After the prescription image gets processed and the data gets sent back to the user, the app prompts the user to login to their Google account using Auth0. This allows us to use Google Cloud's calendar API to create events for when the user should take the medication, containing other relevant drug information as well.

## Challenges we ran into
It was our first time using Flutter with mobile app development, so it took a lot of time to get used to it and really understand how it worked. It was also the first time many of us used all of the various technologies that we tried to incorporate into our project.

## Accomplishments that we're proud of
We are proud of all of the progress that we have made in a day and figuring out how to use the various technologies from Flutter to Google Cloud and Auth0.

## What's next for RxScanner
We would like to improve the image processing to be more robust and handle text recognition better. We would also like to improve the graphics of the app in the future, and add more features, such as a drug pill identifier based on an image that the user takes of the pill.
