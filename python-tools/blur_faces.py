import face_recognition
import cv2
import tqdm

from scipy.io import loadmat


import matplotlib.pyplot as plt

if __name__ == '__main__':
    f_video = '../data/sample.mat'

    data = loadmat(f_video)
    images = data['image_record'].T

    for image in tqdm.tqdm(images):
        # Resize frame of video to 1/4 size for faster face detection processing
        frame = image[0]
        # small_frame = cv2.resize(frame, (0, 0), fx=0.5, fy=0.5)

        # Find all the faces and face encodings in the current frame of video
        face_locations = face_recognition.face_locations(frame,
                                                         model="cnn")

        # Display the results
        for top, right, bottom, left in face_locations:
            # Scale back up face locations since the frame we detected in was scaled to 1/4 size
            # top *= 4
            # right *= 4
            # bottom *= 4
            # left *= 4

            # Extract the region of the image that contains the face
            face_image = frame[top:bottom, left:right]

            # Blur the face image
            face_image = cv2.GaussianBlur(face_image, (99, 99), 30)

            # Put the blurred face region back into the frame image
            frame[top:bottom, left:right] = face_image


        plt.imshow(frame)        plt.show()



