PLUGIN_NAME = custom-msk-debezium-plugin
LIBS_DIR = libs
BUILD_DIR = target
DIST_DIR = plugin-dist
ZIP_NAME = $(PLUGIN_NAME).zip
MSK_SECRETS_JAR = $(LIBS_DIR)/msk-config-providers-0.1.0.jar

.PHONY: all clean build zip

all: clean build zip

build:
	mvn clean package

zip:
	@echo "Creating MSK Connect plugin ZIP..."
	mkdir -p $(DIST_DIR)
	cp $(BUILD_DIR)/$(PLUGIN_NAME).jar $(DIST_DIR)/
	cp $(MSK_SECRETS_JAR) $(DIST_DIR)/
	cd $(DIST_DIR) && zip -r ../$(ZIP_NAME) .

clean:
	mvn clean
	rm -rf $(DIST_DIR) $(ZIP_NAME)
