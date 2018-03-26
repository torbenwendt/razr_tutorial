function room = get_room_afc

room.name = 'afc';

% Room dimensions [x, y, z] in meters:
room.boxsize = [6.97, 5.12, 3];

% Frequency base (in Hz) for absorption frequencies
% (must be octave band center frequencies between 250 and 8k Hz):
room.freq = [250 500 1e3 2e3 4e3];

% Wall materials. The order of walls (directions of outside-pointing normal vectors) is:
% {-z, -y, -x, +x, +y, +z}:
%room.materials = material2abscoeff('hall.brick', room.freq)*10;
room.materials = material2abscoeff('hall:draperies', room.freq);

% Position [x, y, z] of sound source in meters:
room.srcpos = [1.40, 3.02, 1.36];

% Position [x, y, z] of receiver in meters:
room.recpos = [2.77, 1.30, 1.51];

% Orientation [azimuth, elevation] of receiver in degrees
% (angle convention: )
room.recdir	= [90, 0];
