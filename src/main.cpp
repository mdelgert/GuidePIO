#include <Arduino.h>

#define LED_PIN LED_BUILTIN

void setup()
{
    Serial.begin(115200);
    pinMode(LED_PIN, OUTPUT);
    Serial.println("Setup complete!");
}

void loop()
{
    Serial.println("Hello Guide!");
    digitalWrite(LED_PIN, HIGH);
    delay(1000);
    digitalWrite(LED_PIN, LOW);
    delay(1000);                 
}
