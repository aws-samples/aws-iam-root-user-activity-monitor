import json
import boto3
import logging
import os
import botocore.session
from botocore.exceptions import ClientError
session = botocore.session.get_session()

logging.basicConfig(level=logging.DEBUG)
logger=logging.getLogger(__name__)
logger.setLevel(logging.DEBUG)

snsclient = boto3.client('sns')
snsARN = os.environ['SNSARN']

def lambda_handler(event, context):	
	eventname = event['detail']['eventName']
	user = event['detail']['userIdentity']['type']
	targetAccount = event['account']
	logger.debug("Event is --- {0}".format(event))
	logger.debug("Event Name is --- {0}".format(eventname))
	logger.debug("SNS ARN is --- {0}".format(snsARN))
	logger.debug("Principal is --- {0}".format(user))
	logger.debug("AWS AccountId is --- {0}".format(targetAccount))

	try: 
		#Sending the notification...
		snspublish = snsclient.publish(
						TargetArn= snsARN,
						Subject=(("AWS IAM Root User API call-\"{0}\" detected in Account-\"{1}\"".format(eventname,targetAccount))[:100]),
						Message=json.dumps({'default':json.dumps(event)}),
						MessageStructure='json'
					)
		logger.debug("SNS publish response is -- {0}".format(snspublish))
	except ClientError as e:
		logger.error("An error occured: {0}".format(e))
