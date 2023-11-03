unit Datos;

interface

const
  Rumbos : Array [1..16] of String = ('N','NNW','NW','WNW',
                                      'W','WSW','SW','SSW',
                                      'S','SSE','SE','ESE',
                                      'E','ENE','NE','NNE');

  Magnitudes : Array [1..6] of String = ('W(m/s)','Vc(cm/s)',
                                         'Direc(g)','f(g/cm/s)',
                                         'D(m)', 'Wmax(m/s)');

  GRumbos : Array [1..16] of Real = (0, 22.5,45,67.5,
                                     90,112.5,135,157.5,
                                     180,202.5,225,247.5,
                                     270,292.5,315,337.5);

implementation

end.
