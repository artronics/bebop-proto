.SILENT:

environment = dev
aws_profile = apim-dev
tr_vars=
tr_cmd = AWS_PROFILE=$(aws_profile) terraform

-include .env

docker-login:
	aws ecr get-login-password --profile $(aws_profile) --region eu-west-2 | docker login --username AWS --password-stdin $(aws_account_no).dkr.ecr.eu-west-2.amazonaws.com

test:
	curl -X GET --key client.key --cert truststore.crt -i https://$(environment).bars.dev.api.platform.nhs.uk/mock-receiver/Appointment

clean:
	rm -rf build .terraform upload-key

mock_receiver_repository_name = barz-proto-dev-mock-receiver
mock_receiver_repository_url = $(aws_account_no).dkr.ecr.eu-west-2.amazonaws.com/$(mock_receiver_repository_name)

docker-build-sandbox:
	#cp -r ../specification/examples ../sandbox/src/routes
	docker build --platform linux/amd64 -t $(mock_receiver_repository_name):$(environment) -f ../sandbox/Dockerfile ../sandbox

docker-tag-sandbox: docker-build-sandbox
	docker tag $(mock_receiver_repository_name):$(environment) $(mock_receiver_repository_url):$(environment)

docker-push-sandbox: docker-tag-sandbox docker-login
	docker push $(mock_receiver_repository_url):$(environment)
