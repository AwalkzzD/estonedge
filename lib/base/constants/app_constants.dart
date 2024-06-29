// Timeout Constants
const int connectionTimeout = 10;
const int readTimeout = 10;
const int writeTimeout = 10;

// API BaseUrl
const String baseUrl =
    'https://qc9wlso2vh.execute-api.eu-north-1.amazonaws.com/v1/';

// API Endpoints
const String boardTypes = 'boardTypes';
const String users = 'users';
const String rooms = 'rooms';
const String boards = 'boards';

// validation constants
const int ssidLength = 12;
const int passwordLength = 8;

// room images
const List<String> roomImages = [
  'https://drive.google.com/uc?export=view&id=1Ow-9BYPgrQSV_K9fOxUXOAjUi-BSusXV',
  'https://drive.google.com/uc?export=view&id=1TmvRjjBjbEHJoV_yaH3IpgAFbpxVDoEZ',
  'https://drive.google.com/uc?export=view&id=1-z0v842TQlqXIg-aywB78_Cp8fcSVwlS',
  'https://drive.google.com/uc?export=view&id=1TEbGU26a1DGrkSXqUWet6NKPSdkXI4B1',
  'https://drive.google.com/uc?export=view&id=1PUhK7Uaop8HbxFGwnCpwx9OXnLfl2t0Z',
  'https://drive.google.com/uc?export=view&id=1Nt7W4Y0JuD9Veguss8R9H_jFwGf4K5LL',
];

// genders
const List<String?> gendersList = [
  'Male',
  'Female',
  'Non-Binary',
  'Prefer not to answer',
];
