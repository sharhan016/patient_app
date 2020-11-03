DateTime today = DateTime.now();
DateTime modified = today.subtract(new Duration(days: 10));
var date = modified.toString();

Object data = [
  {
    "doctor_id": "1",
    "doctor_name" : "Sania Lin",
    "department" : "Gynaecologist",
    "last_consulted": date,
    "image": "image location"
  },
  {
    "doctor_id": "2",
    "doctor_name" : "Neha Gupta",
    "department" : "Pediatrician",
    "last_consulted": date,
    "image": "image location"
  },
  {
    "doctor_id": "3",
    "doctor_name" : "Anil Lin",
    "department" : "Gynaecologist",
    "last_consulted": date,
    "image": "image location"
  }
];

Object doctor = {
    "id": 2,
    "profile_pic": "http://api-healthcare.datavivservers.in/media/default.jpg",
    "speciality": {
        "id": 1,
        "tag_name": "General Physician",
        "description": "General Physician Tag"
    },
    "experience": 15,
    "description": "No Description",
    "doctor_qualification": [],
    "fees": 500.0
};