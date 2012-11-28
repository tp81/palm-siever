function ohandles=serialize(handles,filename)

loading = nargout;

% List of handles fields to save
fields={...
    'pXAxis', 'String',...
    'pXAxis', 'Value',...
    'pYAxis', 'String',...
    'pYAxis', 'Value',...
    'pZAxis', 'String',...
    'pZAxis', 'Value',...
    'pID', 'String',...
    'pID', 'Value',...
    'fDeltaZ', 'String',...
    'pResolution', 'Value',...
    'tParameters', 'Data',...
    'tParameters', 'RowName',...
    'minC', 'String',...
    'maxC', 'String',...
    'tBins', 'String',...
    'tGamma','String',...
    'tNumPoints', 'String',...
    'radius', 'String',...
    'length', 'String',...
    'pShow', 'Value',...
    'sigma', 'String',...
    'pColormap', 'String',...
    'pColormap', 'Value',...
    'tBins', 'String',...
    'tFilename', 'String',...
};

vars = getVariables(handles);

vars{end+1} = 'subset';
vars{end+1} = 'range';
vars{end+1} = 'myhandlez';
vars{end+1} = 'settingz';

if loading
    ohandles = handles;
    
    % Load file
    evalin('base',['load(''' filename ''')']);
    
    myhandlez=evalin('base','myhandlez');
    settingz=evalin('base','settingz');
    evalin('base','clear myhandlez settingz');
    
    % Put everything in the right place
    for i = 1:2:numel(fields)
        f = fields{i};
        sett = fields{i+1};
        
        set(ohandles.(f),sett,myhandlez.(f).(sett));
    end
    
    ohandles.settings = settingz;
else
    % Put all values into a structure
    for i = 1:2:numel(fields)
        f = fields{i};
        sett = fields{i+1};
        
        myhandlez.(f).(sett) = get(handles.(f),sett);
    end
    
    % Save handles & other vars
    assignin('base','myhandlez',myhandlez);
    assignin('base','settingz',handles.settings);
    assignin('base','vars',vars);
    
    evalin('base',['save(''' filename ''', vars{:})']);
    
    evalin('base','clear vars myhandlez settingz');
end

