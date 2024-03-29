DROP TABLE property_tracker;

CREATE TABLE property_tracker(
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT2,
  number_of_bedrooms INT2,
  year_built INT2,
  buy_let_status VARCHAR(255),
  square_footage INT2,
  build VARCHAR(255)
);
