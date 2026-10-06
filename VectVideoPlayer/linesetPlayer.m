function linesetPlayer(linesetData, fps, w, h, audioInfo, varargin)
%%LINESETPLAYER Play a lineset + data generated from video2lineset()

if isempty(linesetData)
    fprintf("No data to play.\n");
    return;
end

% Обробка опціональних параметрів (Name-Value pairs)
opts.BackgroundColor = [0.97, 0.97, 0.97];
opts.LineColor = [0, 0, 0];
opts.AxisColor = [0, 0, 0];
opts.LineWidth = 1;
opts.Debug = false;
opts.LineColorSequence = {};

for idx = 1:2:length(varargin)
    param = varargin{idx};
    val = varargin{idx+1};
    switch lower(param)
        case 'backgroundcolor'
            opts.BackgroundColor = val;
        case 'linecolor'
            opts.LineColor = val;
        case 'axiscolor'
            opts.AxisColor = val;
        case 'linewidth'
            opts.LineWidth = val;
        case 'debug'
            opts.Debug = val;
        case 'linecolorsequence'
            opts.LineColorSequence = val;
    end
end

ss = get(0, 'ScreenSize');
window_w = w; window_h = h;
if w > ss(3)
    window_w = ss(3);
end
if h > ss(4)
    window_h = ss(4);
end

f = figure('Position', [round((ss(3)-window_w)/2), round((ss(4)-window_h)/2), window_w, window_h], ...
           'Color', opts.BackgroundColor);

a = axes('Parent', f, 'XLim', [0, w], 'YLim', [0, h], 'Box', 'on', ...
         'NextPlot', 'replacechildren', 'Color', opts.BackgroundColor);

set(a, 'XColor', opts.AxisColor, 'YColor', opts.AxisColor);
axis(a, 'equal');

numFrames = length(linesetData);
frameDuration = 1.0 / double(fps);

aplayer = [];
if isstruct(audioInfo) && isfield(audioInfo, 'y') && isfield(audioInfo, 'fs') && ~isempty(audioInfo.y)
    try
        aplayer = audioplayer(audioInfo.y, audioInfo.fs);
    catch
        aplayer = [];
    end
end

i = 1;
playbackStartTime = tic;

while i <= numFrames
    currentTime = toc(playbackStartTime);
    targetFrameStartTime = double(i-1) * frameDuration;

    % Пропуск кадрів у разі затримки
    while currentTime > (targetFrameStartTime + frameDuration) && i <= numFrames
        if opts.Debug
            fprintf("Skipping frame %d (Current Time: %.3fs > Target End Time: %.3fs)\n", ...
                i, currentTime, targetFrameStartTime + frameDuration);
        end
        i = i + 1;
        if i > numFrames
            break;
        end
        targetFrameStartTime = double(i-1) * frameDuration;
        currentTime = toc(playbackStartTime);
    end

    if i > numFrames
        break;
    end

    lineset = linesetData{i};

    % Захист від миготіння: малюємо та очищаємо полотно лише якщо є контури
    if ~isempty(lineset)
        cla(a);
        lineColor = opts.LineColor;
        if ~isempty(opts.LineColorSequence)
            for k = 1:length(opts.LineColorSequence)
                if i >= opts.LineColorSequence{k}{1} && i <= opts.LineColorSequence{k}{2} && ~isempty(opts.LineColorSequence{k}{3})
                    lineColor = opts.LineColorSequence{k}{3};
                    break;
                end
            end
        end

        hold(a, 'on');
        for k = 1:length(lineset)
            if ~isempty(lineset{k}) && size(lineset{k}, 1) > 0
                line(double(lineset{k}(:,1)), double(lineset{k}(:,2)), ...
                     'Parent', a, 'Color', lineColor, 'LineWidth', opts.LineWidth);
            end
        end
        hold(a, 'off');
        set(a, 'XLim', [0, w], 'YLim', [0, h]);
    end

    if ~isempty(aplayer) && i == 1
        play(aplayer);
    end

    drawnow;

    nextFrameTargetTime = double(i) * frameDuration;
    currentTime = toc(playbackStartTime);
    pauseDuration = nextFrameTargetTime - currentTime;

    if pauseDuration < 0
        if i ~= 1 && opts.Debug
            fprintf("Frame %d draw overrun by %.3f ms. No pause.\n", i, -pauseDuration*1000);
        end
    else
        pause(pauseDuration);
    end

    i = i + 1;
end

totalDuration = toc(playbackStartTime);
expectedDuration = double(numFrames) / double(fps);
if opts.Debug
    fprintf("Total elapsed time: %.3f seconds.\n", totalDuration);
    fprintf("Expected duration:  %.3f seconds.\n", expectedDuration);
end

end
