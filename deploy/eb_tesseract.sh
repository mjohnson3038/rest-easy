sudo yum install autoconf aclocal automake
sudo yum install libtool
sudo yum install libjpeg-devel libpng-devel libtiff-devel zlib-devel

# Install Leptonica
#
cd ~/libs mkdir leptonica && cd leptonica
wget http://www.leptonica.com/source/
leptonica-1.69.tar.gz
tar -zxvf leptonica-1.69.tar.gz
cd leptonica-1.69
./configure
make # Takes ~20 minutes on T1 Micro Instance machine 
sudo make install

# Install Tesseract

cd ~/libs mkdir tesseract && cd tesseract
wget http://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.02.tar.gz
tar -zxvf tesseract-ocr-3.02.02.tar.gz
cd tesseract-ocr
./autogen.sh
./configure
make # Takes ~40 minutes on T1 Micro Instance machine
sudo make install
sudo ldconfig

# Tesseract training data

cd /usr/local/share/tessdata
sudo wget http://tesseract-ocr.googlecode.com/files/tesseract-ocr-3.02.eng.tar.gz
sudo tar xvf tesseract-ocr-3.02.eng.tar.gz
export TESSDATA_PREFIX=/usr/local/share/
sudo mv tesseract-ocr/tessdata/* .

# Source TESSERACT_PREFIX

vi ~/.bash_profile

# Copy this line to the end

export TESSDATA_PREFIX=/usr/local/share/

# Verify

tesseract
