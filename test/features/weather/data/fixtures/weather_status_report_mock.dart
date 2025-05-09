const jsonMock = {
  "lat": 30.00,
  "lon": 30.00,
  "current": {
    "temp": 292.55,
    "pressure": 1014,
    "humidity": 89,
    "wind_speed": 3.13,
    "wind_deg": 93,
    "weather": [
      {
        "id": 803,
        "main": "Clouds",
        "description": "broken clouds",
        "icon": "04d"
      }
    ]
  },
  "hourly": [
    {
      "dt": 1684926000,
      "temp": 292.01,
      "pressure": 1014,
      "humidity": 91,
      "wind_speed": 2.58,
      "wind_deg": 86,
      "weather": [
        {
          "id": 803,
          "main": "Clouds",
          "description": "broken clouds",
          "icon": "04n"
        }
      ],
    },
  ],
  "daily": [
    {
      "dt": 1684951200,
      "temp": {
        "min": 290.69,
        "max": 300.35,
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "light rain",
          "icon": "10d",
        }
      ],
    },
  ],
};
