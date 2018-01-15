function demoImChamferDistance(varargin)
%DEMOIMCHAMFERDISTANCE computes distance function inside a complex particle
%
%   output = demoImChamferDistance(input)
%
%   Example
%   demoImChamferDistance
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-02,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

%% Read image a create marker

% read image
img = imread('circles.png');

% create marker
marker = false(size(img));
marker(80, 80) = 1;

% show image
imshow(matImage.imFilters.imOverlay(img, imdilate(marker, ones(3, 3))));


%% compute using quasi-enclidean weights

% compute distance map
dist = matImage.imGeodesics.imChamferDistance(img, marker);

% convert to rgb (use function in 'imFilters')
rgb = matImage.imFilters.double2rgb(dist, jet, [], [1 1 1]);

% display result
figure; 
imshow(rgb);

% decorate
title('Quasi-euclidean distance');


%% compute using integer weights, giving integer results

% compute distance using integer weights
dist34 = matImage.imGeodesics.imChamferDistance(img, marker, int16([3 4]));

% convert to double and normalize
dist34d = double(dist34);
dist34d = dist34d / 3;
dist34d(~img) = inf;

% convert to RGB
bounds = [0 210];
rgb34 = matImage.imFilters.double2rgb(dist34d, jet, bounds, [1 1 1]);

% display rgb
figure;
imshow(rgb34);

% decorate
title('Borgefors 3-4 weights');
 
