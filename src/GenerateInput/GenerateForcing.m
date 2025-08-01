function FORCING = GenerateForcing(forcing_path, Coordinate, starttime, endtime)
variables = ["temp","prcp","pres","shum","srad","lrad","wind"];
% temp = [];
% prcp = [];
% pres = [];
% shum = [];
% srad = [];
% lrad = [];
% wind = [];
for var = variables
    forcingfile = fullfile(forcing_path,"tpmfd_" + var + "_h_19790101_20221231.nc");
    % lon_index = Coordinate(1);
    % lat_index = Coordinate(2);
    vardata = ncread(forcingfile,var);
    if var == "temp"
        varlon = ncread(forcingfile,"longitude");
        varlat = ncread(forcingfile,"latitude");
        vartime = ncread(forcingfile,"time");
    end
    [~,lon_index] = min(abs(varlon - Coordinate(1)));
    [~,lat_index] = min(abs(varlat - Coordinate(2)));
    if strcmp(var,"temp")
        FORCING.Tair = squeeze(vardata(lon_index,lat_index,:));
    elseif strcmp(var,"prcp")
        FORCING.Prcp = squeeze(vardata(lon_index,lat_index,:));
    elseif strcmp(var,"pres")
        FORCING.p = squeeze(vardata(lon_index,lat_index,:));
    elseif strcmp(var,"shum")
        FORCING.Sin = squeeze(vardata(lon_index,lat_index,:));
    elseif strcmp(var, "lrad")
        FORCING.Lin = squeeze(vardata(lon_index,lat_index,:));
    elseif strcmp(var,"wind")
        FORCING.wind = squeeze(vardata(lon_index,lat_index,:));
    end
end
FORCING.Tair = FORCING.Tair - 273.15;
FORCING.time = vartime;
end

