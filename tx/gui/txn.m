%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       Written in Metalink Broadband
%       www.metalinkbb.com
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function varargout = txn(varargin)
% TXN M-file for txn.fig
%      TXN, by itself, creates a new TXN or raises the existing
%      singleton*.
%
%      H = TXN returns the handle to a new TXN or the handle to
%      the existing singleton*.
%
%      TXN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TXN.M with the given input arguments.
%
%      TXN('Property','Value',...) creates a new TXN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before txn_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to txn_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help txn

% Last Modified by GUIDE v2.5 25-Dec-2006 14:02:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @txn_OpeningFcn, ...
                   'gui_OutputFcn',  @txn_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before txn is made visible.
function txn_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to txn (see VARARGIN)

% Choose default command line output for txn
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes txn wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = txn_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in format.
function format_Callback(hObject, eventdata, handles)
% hObject    handle to format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from format


% --- Executes during object creation, after setting all properties.
function format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in l_length.
function l_length_Callback(hObject, eventdata, handles)
% hObject    handle to l_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns l_length contents as cell array
%        contents{get(hObject,'Value')} returns selected item from l_length


% --- Executes during object creation, after setting all properties.
function l_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to l_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in length.
function length_Callback(hObject, eventdata, handles)
% hObject    handle to length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns length contents as cell array
%        contents{get(hObject,'Value')} returns selected item from length


% --- Executes during object creation, after setting all properties.
function length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mcs_Callback(hObject, eventdata, handles)
% hObject    handle to mcs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mcs as text
%        str2double(get(hObject,'String')) returns contents of mcs as a double


% --- Executes during object creation, after setting all properties.
function mcs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mcs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in stbc.
function stbc_Callback(hObject, eventdata, handles)
% hObject    handle to stbc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns stbc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stbc


% --- Executes during object creation, after setting all properties.
function stbc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stbc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in num_exten_ss.
function num_exten_ss_Callback(hObject, eventdata, handles)
% hObject    handle to num_exten_ss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns num_exten_ss contents as cell array
%        contents{get(hObject,'Value')} returns selected item from num_exten_ss


% --- Executes during object creation, after setting all properties.
function num_exten_ss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_exten_ss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ntx.
function ntx_Callback(hObject, eventdata, handles)
% hObject    handle to ntx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ntx contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ntx


% --- Executes during object creation, after setting all properties.
function ntx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ntx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in output_rate.
function output_rate_Callback(hObject, eventdata, handles)
% hObject    handle to output_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns output_rate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from output_rate


% --- Executes during object creation, after setting all properties.
function output_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to output_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cw.
function cw_Callback(hObject, eventdata, handles)
% hObject    handle to cw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns cw contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cw


% --- Executes during object creation, after setting all properties.
function cw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cw_offset.
function cw_offset_Callback(hObject, eventdata, handles)
% hObject    handle to cw_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns cw_offset contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cw_offset


% --- Executes during object creation, after setting all properties.
function cw_offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cw_offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in short_gi.
function short_gi_Callback(hObject, eventdata, handles)
% hObject    handle to short_gi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns short_gi contents as cell array
%        contents{get(hObject,'Value')} returns selected item from short_gi


% --- Executes during object creation, after setting all properties.
function short_gi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to short_gi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function win_Callback(hObject, eventdata, handles)
% hObject    handle to win (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of win as text
%        str2double(get(hObject,'String')) returns contents of win as a double


% --- Executes during object creation, after setting all properties.
function win_CreateFcn(hObject, eventdata, handles)
% hObject    handle to win (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in calib.
function calib_Callback(hObject, eventdata, handles)
% hObject    handle to calib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns calib contents as cell array
%        contents{get(hObject,'Value')} returns selected item from calib


% --- Executes during object creation, after setting all properties.
function calib_CreateFcn(hObject, eventdata, handles)
% hObject    handle to calib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in bf_q_source.
function bf_q_source_Callback(hObject, eventdata, handles)
% hObject    handle to bf_q_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns bf_q_source contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bf_q_source


% --- Executes during object creation, after setting all properties.
function bf_q_source_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bf_q_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bit_source_Callback(hObject, eventdata, handles)
% hObject    handle to bit_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bit_source as text
%        str2double(get(hObject,'String')) returns contents of bit_source as a double


% --- Executes during object creation, after setting all properties.
function bit_source_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bit_source (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function service_scrabler_start_Callback(hObject, eventdata, handles)
% hObject    handle to service_scrabler_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of service_scrabler_start as text
%        str2double(get(hObject,'String')) returns contents of service_scrabler_start as a double


% --- Executes during object creation, after setting all properties.
function service_scrabler_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to service_scrabler_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function service_bits_Callback(hObject, eventdata, handles)
% hObject    handle to service_bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of service_bits as text
%        str2double(get(hObject,'String')) returns contents of service_bits as a double


% --- Executes during object creation, after setting all properties.
function service_bits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to service_bits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in smoothing.
function smoothing_Callback(hObject, eventdata, handles)
% hObject    handle to smoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns smoothing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from smoothing


% --- Executes during object creation, after setting all properties.
function smoothing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoothing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sounding.
function sounding_Callback(hObject, eventdata, handles)
% hObject    handle to sounding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns sounding contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sounding


% --- Executes during object creation, after setting all properties.
function sounding_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sounding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ldpc_coding.
function ldpc_coding_Callback(hObject, eventdata, handles)
% hObject    handle to ldpc_coding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ldpc_coding contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ldpc_coding


% --- Executes during object creation, after setting all properties.
function ldpc_coding_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ldpc_coding (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in aggregation.
function aggregation_Callback(hObject, eventdata, handles)
% hObject    handle to aggregation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns aggregation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from aggregation


% --- Executes during object creation, after setting all properties.
function aggregation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aggregation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function post_q_cdd_Callback(hObject, eventdata, handles)
% hObject    handle to post_q_cdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of post_q_cdd as text
%        str2double(get(hObject,'String')) returns contents of post_q_cdd as a double


% --- Executes during object creation, after setting all properties.
function post_q_cdd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to post_q_cdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pre_defined_configuration.
function pre_defined_configuration_Callback(hObject, eventdata, handles)
% hObject    handle to pre_defined_configuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns pre_defined_configuration contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pre_defined_configuration


% --- Executes during object creation, after setting all properties.
function pre_defined_configuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pre_defined_configuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in hidden_mcs_ht.
function hidden_mcs_ht_Callback(hObject, eventdata, handles)
% hObject    handle to hidden_mcs_ht (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns hidden_mcs_ht contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hidden_mcs_ht


% --- Executes during object creation, after setting all properties.
function hidden_mcs_ht_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hidden_mcs_ht (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in hidden_mcs_legacy.
function hidden_mcs_legacy_Callback(hObject, eventdata, handles)
% hObject    handle to hidden_mcs_legacy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns hidden_mcs_legacy contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hidden_mcs_legacy


% --- Executes during object creation, after setting all properties.
function hidden_mcs_legacy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hidden_mcs_legacy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


