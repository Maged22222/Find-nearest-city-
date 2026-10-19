% Define the number of cities
n = 10; % For example, 10 cities

% Generate random 3D coordinates for the cities
cities = rand(n, 3);

% Compute the distance matrix between the cities
distances = pdist2(cities, cities);

% Initialize the tour with the first city
tour = [1];

% Initialize the figure and axes for 3D plotting
figure;
ax = gca;
ax.XLim = [0, 1];
ax.YLim = [0, 1];
ax.ZLim = [0, 1];
hold on;
grid on;
view(3);

% Plot the cities
plot3(cities(:,1), cities(:,2), cities(:,3), 'o');

% Initialize the distance traveled
distance_traveled = 0;

% Visit the nearest unvisited city until all cities have been visited
for i = 2:n 
   unvisited = setdiff(1:n, tour); 
   [~, nearest] = min(distances(tour(end), unvisited));
   next_city = unvisited(nearest);
   
   % Compute the distance to the next city
   distance_to_next_city = distances(tour(end), next_city);

   % Update the tour plot
   plot3(cities([tour(end), next_city], 1), cities([tour(end), next_city], 2), cities([tour(end), next_city], 3), "-");
   drawnow;
   
   % Update the salesman position and distance traveled 
   t_start = tic; 
   while toc(t_start) < 1.5 
       t_elapsed = toc(t_start);
       salesman_pos = cities(tour(end), :) + t_elapsed/1.5 * (cities(next_city, :) - cities(tour(end), :));
       plot3(salesman_pos(1), salesman_pos(2), salesman_pos(3), 'r.', 'MarkerSize', 20);
       drawnow;
   end
   
   % Add the next city to the tour
   tour = [tour, next_city];
   distance_traveled = distance_traveled + distance_to_next_city;
end

% Complete the tour by returning to the starting city
plot3(cities([tour(end), tour(1)], 1), cities([tour(end), tour(1)], 2), cities([tour(end), tour(1)], 3), "-");
drawnow;

% Display the total distance traveled
disp(['Total distance traveled: ', num2str(distance_traveled)]);