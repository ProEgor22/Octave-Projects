function [lineset, fps, w, h, audio] = video2lineset(videoPath, addDetails)
%%VIDEO2LINESET Convert a video file to a lineset for plotting

if nargin < 2
    addDetails = false;
end

video = VideoReader(videoPath);
[~, name, ext] = fileparts(videoPath);

w = video.Width;
h = video.Height;
fps = video.FrameRate;
audio = struct;

try
    wavPath = [tempname(), '.wav'];
    system(sprintf('ffmpeg -y -i "%s" -vn -acodec pcm_s16le "%s" -loglevel quiet', videoPath, wavPath));
    [y, audio_fs] = audioread(wavPath);
    audio.y = y;
    audio.fs = audio_fs;
    if exist(wavPath, 'file')
        delete(wavPath);
    end
catch
    fprintf("Video file does not contain audio or FFmpeg is missing.\n");
end

totalFrames = video.NumberOfFrames;
lineset = cell([totalFrames, 1]);

scaleFactor = 0.5;
pointStep = 2;

f = waitbar(0, 'Retrieving video metadata...', 'Name', strcat(name, ext));

% Використовуємо чіткий цикл for замість while hasFrame, щоб уникнути зависання
for i = 1:totalFrames
    if mod(i, 10) == 0 || i == totalFrames
        progress = i / totalFrames;
        if ishandle(f)
            try
                waitbar(progress, f, sprintf("Frame %d / %d (%.2f%%)", i, totalFrames, progress * 100));
            catch
                disp("Operation aborted by user.");
                return;
            end
        end
    end

    try
        if ~hasFrame(video)
            break;
        end
        I = readFrame(video);
    catch
        % Якщо відео закінчилось раніше метаданих — виходимо з циклу
        break;
    end

    if isempty(I)
        continue;
    end

    if scaleFactor ~= 1
        I = imresize(I, scaleFactor);
    end

    if ndims(I) == 3 && size(I, 3) == 3
        I = rgb2gray(I);
    end

    BW = imbinarize(I);

    if addDetails
        edges = edge(I, 'Canny');
        BW = BW | edges;
    end

    BW = flip(BW)';
    [B, ~] = bwboundaries(BW, 8, 'holes');
    poly = cell([length(B), 1]);

    for k = 1:length(B)
        po = B{k};
        poly{k,1} = po(1:pointStep:end, :);
    end

    lineset{i,1} = poly;
end

% Прибираємо порожні осередки, якщо кадрів виявилося менше ніж totalFrames
validFrames = ~cellfun(@isempty, lineset);
lineset = lineset(validFrames);

% Гарантовано закриваємо waitbar
if exist('f', 'var') && ishandle(f)
    delete(f);
end

% Автоматичне збереження
save([name, '_lineset.mat'], 'lineset', 'fps', 'w', 'h', 'audio');
fprintf("\nFinished! Processed %d frames. Saved to %s_lineset.mat\n", length(lineset), name);

end
