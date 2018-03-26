% rap_user - stimulus generation function of experiment 'rap' -
%
% This function is called by afc_main when starting
% the experiment 'example'. It generates the stimuli which
% are presented during the experiment.
% The stimuli must be elements of the structure 'work' as follows:
%
% work.signal = def.intervallen by 2 times def.intervalnum matrix.
%               The first two columns must contain the test signal
%               (column 1 = left, column 2 = right) ...
% 
% work.presig = def.presiglen by 2 matrix.
%               The pre-signal. 
%               (column 1 = left, column 2 = right).
%
% work.postsig = def.postsiglen by 2 matrix.
%                The post-signal. 
%               ( column 1 = left, column 2 = right).
%
% work.pausesig = def.pausesiglen by 2 matrix.
%                 The pause-signal. 
%                 (column 1 = left, column 2 = right).
% 
% To design an own experiment, e.g., 'myexperiment',
% make changes in this file and save it as 'myexperiment_user.m'.
% Ensure that the referenced elements of structure 'work' are existing.
%
% See also help example_cfg, example_set, afc_main

function rap_user

global def
global work
global setup

work.room.materials = setup.materials_orig*10^(work.expvaract/20);

% display tracking variable and resulting absorption coefficients:
if 1
    disp(work.expvaract);
    disp(work.room.materials);
end

ir_test = razr(work.room, work.op);
out = apply_rir(ir_test, 'src', setup.src_sig, 'normalize', true, ...
    'samples', setup.samples, 'win', setup.win);
sig_test = fit_len(out{1}, setup.winlen);

tref1 = setup.sig_ref;
tref2 = setup.sig_ref;
tuser = sig_test;

% Hanning windows
tref1 = tref1 .* setup.window;
tref2 = tref2 .* setup.window;
tuser = tuser .* setup.window;

% pre-, post- and pausesignals (all zeros)
presig   = zeros(def.presiglen,2);
postsig  = zeros(def.postsiglen,2);
pausesig = zeros(def.pauselen,2);

% make required fields in work
work.signal   = [tuser tref1 tref2];	% left = right (diotic) first two columns holds the test signal (left right)
work.presig   = presig;									% must contain the presignal
work.postsig  = postsig;								% must contain the postsignal
work.pausesig = pausesig;								% must contain the pausesignal

% eof