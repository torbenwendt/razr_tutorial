% rap_set - setup function of experiment 'rap' -
%
% This function is called by afc_main when starting
% the experiment 'example'. It defines elements
% of the structure 'setup'. The elements of 'setup' are used 
% by the function 'example_user.m'.
% 
% If an experiments can be started with different experimental 
% conditions, e.g, presentation at different sound preasure levels,
% one might switch between different condition dependent elements 
% of structure 'setup' here.
%
% For most experiments it is also suitable to pregenerate some 
% stimuli here.
% 
% To design an own experiment, e.g., 'myexperiment',
% make changes in this file and save it as 'myexperiment_set.m'.
% Ensure that this function does exist, even if absolutely nothing 
% is done here.
%
% See also help example_cfg, example_user, afc_main

function rap_set

global def
global work
global setup

% make condition dependend entries in structure set

work.room = get_room_afc;  % stored in afc/procedures
setup.materials_orig = work.room.materials;

work.op.fs = def.samplerate;

ir_ref = razr(work.room, work.op);

signallen = round(def.intervallen*0.15);

switch work.condition
case 'noise'
   setup.src_sig = randn(signallen, 1);
   setup.src_sig = setup.src_sig./max(abs(setup.src_sig));
   % parameters for apply_rir:
   setup.samples = [];
   setup.win = [0, 0];
case 'speech'
   setup.src_sig = 'olsa1';
   % parameters for apply_rir:
   setup.samples = [1, 20100];
   setup.win = [0, 50];
otherwise
   error('condition not recognized');
end

out = apply_rir(ir_ref, 'src', setup.src_sig, 'normalize', true, ...
    'samples', setup.samples, 'win', setup.win);
setup.sig_ref = out{1};

% define the calibration level (assume 90 dB SPL for 0 dB FS)
work.currentCalLevel = 100;

% define signals in structure setup
setup.modsine = sin([0:def.intervallen-1]'*2*pi*work.exppar1/def.samplerate);
setup.hannlen = round(0.05*def.samplerate);
setup.window = hannfl(def.intervallen, setup.hannlen, setup.hannlen);
setup.window = repmat(setup.window, 1, 2);  % mono2diotic

setup.winlen = length(setup.window);

setup.sig_ref = fit_len(setup.sig_ref, setup.winlen);

% eof