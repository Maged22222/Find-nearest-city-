% Function to find the nearest unvisited city
function next_city = findNearestCity(current_city, unvisited, distances)
    [~, nearest] = min(distances(current_city, unvisited));
    next_city = unvisited(nearest);
end