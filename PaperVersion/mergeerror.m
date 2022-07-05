function  [err]=mergeerror(err)

try
    mergederror=[err.dLNa+err.dLNaright]./2;
catch
    mergederror=[err.dLNa+err.dLNaRight]./2;
end
err=rmfield(err,"dLNa");
try
    err=rmfield(err,"dLNaright");
catch
    err=rmfield(err,"dLNaRight");
end

err.dLNasingle=mergederror;

end
