from __future__ import print_function
import csv
import os 
import sys
import uuid
import ntpath
import boto3
import logging


s3_client = boto3.client("s3")

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def create_dirs(path):
    dir = os.path.dirname(path)
    if not os.path.exists(dir):
        os.makedirs(dir)

def analyze_data(input_file_path, output_file_path, file_name):
    fieldnames = ["wavelength", "intensity"]
    with open(input_file_path) as input_file:

        data = csv.DictReader(input_file, fieldnames=fieldnames)
        logger.info("PA-1: data, %s", data)

        max_intensity = None
        max_wavelength = None

        # Find max intensity
        for row in data:
            intensity = float(row["intensity"])
            if max_intensity == None or max_intensity < intensity:
                max_intensity = intensity
                max_wavelength = int(row["wavelength"])
                logger.info("PA-2: max_intensity, max_wavelength %s %s", max_intensity, max_wavelength)

        if max_intensity:
            max_values = { "concentration": int(file_name[7:-4]), "wavelength": max_wavelength, "intensity": max_intensity }
            #max_values = { "wavelength": max_wavelength, "intensity": max_intensity }
            logger.info("PA-3: found max values for intensity, wavelength %s %s", max_intensity, max_wavelength)
            out_field_names = max_values.keys()
            with open(output_file_path, "wb") as output_file:
                logger.info("PA-4: writing max values for intensity, wavelength %s", max_values)
                writer = csv.DictWriter(output_file, fieldnames = out_field_names)
                writer.writerow(max_values)

def handle(event, context):
    for record in event['Records']:
        logger.info("PY-1: Event, Context %s, %s", event, context)
        bucket = record['s3']['bucket']['name']
        key = record['s3']['object']['key'] 
        logger.info("PY-2: bucket_name %s", bucket)
        logger.info("PY-3: key %s", key)

        download_path = '/tmp/{}{}'.format(uuid.uuid4(), key)
        create_dirs(download_path)
        upload_path = '/tmp/analyzed-{}'.format(key)
        create_dirs(upload_path)

        object_name = os.path.basename(download_path)
        logger.info("PY-4: downloaded location and filename: %s %s", download_path, object_name)
        logger.info("PY-4: upload location: %s", upload_path)
        
        s3_client.download_file(bucket, key, download_path)
        analyze_data(download_path, upload_path, object_name)
        logger.info("PY-5: uploading file to S3 (path, bucket, key)  %s %s %s", upload_path, '{}analyzed'.format(bucket), key)
        s3_client.upload_file(upload_path, '{}analyzed'.format(bucket), key)

