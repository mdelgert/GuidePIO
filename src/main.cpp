#include <Arduino.h>

void setup() {
    Serial.begin(115200);
    Serial.println("Setup complete!");
}

void loop() {
    Serial.println("Hello Guide!");
    delay(1000);
}
