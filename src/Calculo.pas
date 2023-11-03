unit Calculo;

interface

const
  VelAng     = 2.3148e-6;
  CoefFricc  = 1;

Function Deflexion(Vel : Real) : Real;
Function VelCorr(Vel, CU, fi : Real) : Real;
Function CFriccion(Vel : Real) : Real;
Function PFriccion(Vel, fi : Real) : Real;
Function DeflexionPFin(a, Prof : Real) : Real;
Function VelCorrPFin(Vel, CU, fi, a, Prof : Real) : Real;
Function CFriccionPFin(Vel : Real) : Real;
Function PFriccionPFin(a : Real) : Real;
Function a(Dens, fi : Real) : Real;

implementation

Uses math;

Function Deflexion(Vel : Real) : Real;
begin
  Deflexion := 34 - 7.5 * sqrt(Vel);
end;

Function VelCorr(Vel, CU, fi : Real) : Real;
begin
  VelCorr := CU * Vel * 100 / sqrt(sin(DegToRad(fi)));
end;

Function CFriccion(Vel : Real) : Real;
begin
  If Vel <= 6 Then
    CFriccion := 1.03 * sqr(Vel) * Vel
  Else
    CFriccion := 4.3 * sqr(Vel)
end;

Function PFriccion(Vel, fi : Real) : Real;
begin
  PFriccion := 7.6 * Vel / Sqrt(sin(DegToRad(fi)))
end;

Function DeflexionPFin(a, Prof : Real) : Real;
begin
  DeflexionPFin := 45 - a * Prof;
end;

Function VelCorrPFin(Vel, CU, fi, a, Prof : Real) : Real;
begin
  VelCorrPFin := CU * Vel * 100 * exp(-a * Prof)/ sqrt(sin(DegToRad(fi)));
end;

Function CFriccionPFin(Vel : Real) : Real;
begin
  CFriccionPFin := CFriccion(Vel)
end;

Function PFriccionPFin(a : Real) : Real;
begin
  PFriccionPFin := pi / a;
end;

Function a(Dens, fi : Real) : Real;
begin
  a :=  sqrt(Dens * VelAng * sin(DegToRad(fi)) / CoefFricc)
end;

end.
