PLUGIN_NAME = debezium-connector-mariadb
VERSION=3.0.8
LIBS_DIR = libs
BUILD_DIR = target
DIST_DIR = plugin-dist
ZIP_NAME = $(PLUGIN_NAME).zip
MSK_SECRETS_JAR = $(LIBS_DIR)/msk-config-providers-0.1.0.jar

.PHONY: all clean prepare build zip

all: clean prepare build zip

prepare:
	wget https://github.com/aws-samples/msk-config-providers/releases/download/r0.1.0/msk-config-providers-0.1.0-with-dependencies.zip
	unzip msk-config-providers-0.1.0-with-dependencies.zip
	rm msk-config-providers-0.1.0-with-dependencies.zip

build:
	mvn clean package

zip:
	mkdir -p $(DIST_DIR)
	cp target/custom-msk-debezium-plugin.jar $(DIST_DIR)
	cp -r lib $(DIST_DIR)
	cp msk-config-providers-0.1.0.jar $(DIST_DIR)
	cd $(DIST_DIR) && zip -r ../$(PLUGIN_NAME)-$(VERSION).zip .

clean:
	mvn clean
	rm -rf $(DIST_DIR) $(ZIP_NAME) $(PLUGIN_NAME) lib *.zip *.jar
