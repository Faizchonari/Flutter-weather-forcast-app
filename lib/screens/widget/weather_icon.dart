String weathericon(int day, int weathercode) {
  switch (weathercode) {
    case 0:
    case 1:
      switch (day) {
        case 0: //Night
          return 'assets/Icons/Clear Sky night.json';
        default:
          return 'assets/Icons/Clear Sky day.json';
      }
    case 2:
      return 'assets/Icons/Partly Cloudy.json';
    case 3:
      switch (day) {
        case 0:
          return 'assets/Icons/Overcast night.json';
        default:
          return 'assets/Icons/Overcast day.json';
      }
    case 45:
    case 48:
      return 'assets/Icons/Fog and Depositng Rime Fog.json';
    case 51:
      switch (day) {
        case 0:
          return 'assets/Icons/Drizzle night.json';
        default:
          return 'assets/Icons/Light Drizzle.json';
      }
    case 53:
    case 55:
      return 'assets/Icons/Moderate Drizzle.json';
    case 57:
      return 'assets/Icons/Dense Freezing Drizzle.json';
    case 61:
      return 'assets/Icons/Slight Rain.json';
    case 63:
      return 'assets/Icons/Moderate Rain.json';
    case 65:
      return 'assets/Icons/Heavy Rain.json';
    case 66:
      return 'assets/Icons/Light Drizzle.json';
    case 67:
      return 'assets/Icons/Dense Freezing Drizzle.json';
    case 71:
    case 73:
    case 75:
    case 77:
      return 'assets/Icons/Snow dark.json';
    case 80:
      return 'assets/Icons/Slight Rain.json';
    case 81:
      switch (day) {
        case 0:
          return 'assets/Icons/Moderate Rain Showers night.json';
        default:
          return 'assets/Icons/Moderate Rain Showers day.json';
      }
    case 82:
      return 'assets/Icons/Heavy Rain.json';
    case 85:
      return 'Slight Snow Showers';
    case 86:
      return 'assets/Icons/Heavy Snow.json';
    case 95:
    case 96:
    case 99:
      switch (day) {
        case 0:
          return 'assets/Icons/Thunderstorm night.json';
        default:
          return 'assets/Icons/Thunderstorm.json';
      }

    default:
      return 'assets/Icons/default.json';
  }
}
