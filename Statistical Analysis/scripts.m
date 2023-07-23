clear 
close all

% % Variables initialization
% data_folder1 = 'assignmentS';
% arena_type1 = '0-general';
% data_folder2 = 'assignmentSM';
% arena_type2 = '0-general';


data=readtable('Stat.xlsx');
dist_source=table2array(data(:,1));
dist_mine=table2array(data(:,2));
laptime_source=table2array(data(:,5));
laptime_mine=table2array(data(:,6));
% Data extraction
distances1 = [dist_source, laptime_source];
distances2 = [dist_mine, laptime_mine];

% Mean value
mean_dist = mean(distances1);

% Standard deviation
std_dev = std(distances1);

% Plot 1
figure;
plot(distances1, 'b', 'LineWidth', 2);
figure;

bar( mean_dist, mean_dist);
xlabel('Number of laps');
ylabel('Lap distance [units]');
legend('Distance Travelled', 'Mean Value');
title(['Lap distance [units] along the basic arena and mean value with standard deviation of: ', num2str(std_dev), ' [units]']);

% Plot 2
figure;
hold on;
dist_sorted = sort(distances1);
histogram(dist_sorted, 5, 'Normalization','pdf');

y = dist_sorted(1):0.1:dist_sorted(end);
mu = mean_dist;
sigma = std_dev;
f = exp(-(y-mu).^2./(2*sigma^2))./(sigma*sqrt(2*pi));
plot(y,f,'LineWidth',2);

legend('Histogram','Normal distribution');
title(['Comparison between histogram and normal distribution with u = ', num2str(mean_dist),' and sigma = ', num2str(std_dev)]);

% Lilliefors Test
lil_test1 = lillietest(distances1);
lil_test2 = lillietest(distances2);

% Wilcoxon rank sum test or t-test depending on Lilliefors Test result
if (lil_test1 == 1 || lil_test2 == 1) % not from normal distribution
    [p,h] = ranksum(distances1,distances2);
elseif (lil_test1 == 0 && lil_test2 == 0) % both from normal distribution
    h_tt = ttest(distances1,distances2);
end

% Boxplot
C = [distances1', distances2'];
grp = [zeros(1,length(distances1)),ones(1,length(distances2))];
%boxplot(C,grp,'Labels',{'assignment','robot-sim'},'Whisker',1);
xlabel('Groups')
ylabel('Lap Distance [m]')
title('Boxplot between lap distance');

% % Function to read data from text files
% function distances = read_data(data_folder, arena_type)
%     file_path = ['../../', num2str(data_folder), '/stats/', num2str(arena_type), '/general_distance_travelled_', num2str(data_folder), '.txt'];
%     text_file_data = readtable(file_path);
%     array_data = text_file_data(:,5);
%     distances = table2array(array_data);
% end

