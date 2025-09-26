import random;

# Walker that predicts weather for a city
walker WeatherPredictor {
    has city: str;
    has guess: str;    # "sunny", "rainy", "cloudy"
    
    can start with `root entry;
    can evaluate with forecast entry;
}

# Node representing a weather forecast for a city
node forecast {
    has actual_weather: str = random.choice(["sunny", "rainy", "cloudy"]);
}

# Entry point: spawn a few predictions
with entry: __main__ {
    root spawn WeatherPredictor("Nairobi", "sunny");
    root spawn WeatherPredictor("Mombasa", "rainy");
    root spawn WeatherPredictor("Kisumu", "cloudy");
}

impl WeatherPredictor.start {
    if not [root -->(`?forecast where here.city == self.city)] {
        # create a forecast node for this city and connect it to root
        next = root ++> forecast(random.choice(["sunny", "rainy", "cloudy"]));
        next.city = self.city;   # tag the node with the same city
    } else {
        next = [root --> (`?forecast where here.city == self.city)];
    }
    visit next;
}

impl WeatherPredictor.evaluate {
    if [-->] {
        visit [-->];
    } else {
        let actual = here.actual_weather;
        let predicted = self.guess;
        print("City: " + self.city + 
              " | Predicted: " + predicted + 
              " | Actual: " + actual);

        if predicted == actual {
            print("Great job! You predicted correctly.");
        } else {
            print("Prediction missed. Better luck next time.");
        }
        disengage;
    }
}
