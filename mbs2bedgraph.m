$$  Matlab script to create combinded bedgraph files from multiBamSummary 

% Load data from createMBS.sh

multiBamSummaryFileName = 'MBS.EBndG.100.50K.txt';
T = readtable(multiBamSummaryFileName);

% convert headers to easier-to-read-headers 
headers = T.Properties.VariableNames;
headers = erase(headers, {'x__', 'x_', '_bam_'});
headers = strip(headers, '_');
T.Properties.VariableNames = headers;

% Extract the data 
data = T{:,4:end};
[~, nCol] = size(data); 
nSamples = nCol/2; 

% normalize to total reads per megabase
total = sum(data);
RPM = data ./ total * 1e6;
# the control data were first columns 
control = RPM(:, 1:nSamples);
sample = RPM(:, [nSamples+1 : nCol]);
log2RPM = log2(sample ./ control); 

% create table to save 
coordinates = T(:,1:3) ;
dataTable = array2table(log2RPM);
S = [coordinates, dataTable];
newFileName = erase(multiBamSummaryFileName, 'MBS')
writetable(S, newFileName);

% Save bedgraph file 
score = table(score);
S = [coordinates, score];
writetable(S, 'EBndG.100.50K.bg', 'Delimiter',"\t", "FileType","text", "WriteVariableNames",false);

%% Correleration Coefficients 

% bedgraph files of the encode motifs 
listing = dir('*.bg')

EBndG = readtable('EBndG.100.50K.txt');
dataEBndG = EBndG{:,4:end}; 

for i = 1: length(listing)
        Motif = readtable(listing(i).name, 'ReadVariableNames', 'false');
		    % Join 
		    J= outerjoin(EBndG, Motif, "Keys",[1 2 3], "MergeKeys",true);

	    % set the no repeats score to zero 
	    data = J{:,4:end}; 
      data(ismissing(data)) = 0 ;

	    %% analyze 
 	    [~, nCol] = size(data);
		  % Correlerate motif vs EBndG data 
      R(i,:) = corr(data(:,nCol), data(:,1:nCol-1) , 'Type', 'Spearman')
end



