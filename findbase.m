function [base, units,axis]=findbase(param)
%returns the base of the parameter name
%also can include the unit if necessary
%returns as strings

if contains(param,'pmove')
    base = 'pmovebase';
    units = ''; %pmove does not have units
    axis = 'P(move)';
elseif contains(param,'groundspeed')
    base = 'groundspeedbase';
    units =  '(mm/s)';
    axis = 'Groundspeed';
elseif contains(param,'upwind')
    base = 'upwindbase';
    units =  '(mm/s)';
    axis = 'Upwind Velocity';
elseif contains(param,'angv')
    base = 'angvbase';
    units =  '(deg/s)';
    axis = 'Angular Velocity';
elseif contains(param,'curvature')
    base = 'curvaturebase';
    units =  '(deg/mm)';
    axis = 'Curvature';
elseif contains(param,'placepref')
    base = 'basepref';
    units = 'mm';
    axis = 'place preference';
else
    disp('parameter name has an error!');
end

end
