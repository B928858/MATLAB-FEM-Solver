classdef SpaceFrameDesigner < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        Toolbar                       matlab.ui.container.Toolbar
        ClearBar                      matlab.ui.container.toolbar.PushTool
        SaveBar                       matlab.ui.container.toolbar.PushTool
        LoadBar                       matlab.ui.container.toolbar.PushTool
        ImportBar                     matlab.ui.container.toolbar.PushTool
        MainGrid                      matlab.ui.container.GridLayout
        OutputsPanel                  matlab.ui.container.Panel
        OuputsGrid                    matlab.ui.container.GridLayout
        MaxDeflect                    matlab.ui.control.NumericEditField
        MaxNodalDeflectionmEditFieldLabel  matlab.ui.control.Label
        MaxVM                         matlab.ui.control.NumericEditField
        MaxElementStressGLabel        matlab.ui.control.Label
        SurfaceThickness              matlab.ui.control.NumericEditField
        SurfaceThicknessmmEditFieldLabel  matlab.ui.control.Label
        SigmaMax                      matlab.ui.control.NumericEditField
        MaxSurfaceLabel               matlab.ui.control.Label
        FrameMass                     matlab.ui.control.NumericEditField
        FrameMasskgLabel              matlab.ui.control.Label
        FEMSolverPanel                matlab.ui.container.Panel
        FEMSolverGrid                 matlab.ui.container.GridLayout
        PlotSurface                   matlab.ui.control.StateButton
        Undeflected                   matlab.ui.control.StateButton
        PlotFEA                       matlab.ui.control.StateButton
        Surface                       matlab.ui.control.StateButton
        MeshResolution                matlab.ui.control.NumericEditField
        MeshResolutionEditFieldLabel  matlab.ui.control.Label
        Acceleration                  matlab.ui.control.NumericEditField
        AccelerationgEditFieldLabel   matlab.ui.control.Label
        Analyse                       matlab.ui.control.Button
        SurfacePropertiesPanel        matlab.ui.container.Panel
        SurfacePropertiesGrid         matlab.ui.container.GridLayout
        MatSurface                    matlab.ui.control.EditField
        MassSurface                   matlab.ui.control.NumericEditField
        DensityLabel                  matlab.ui.control.Label
        DensitygcmLabel               matlab.ui.control.Label
        ESurface                      matlab.ui.control.NumericEditField
        YoungsModulusEGPaLabel        matlab.ui.control.Label
        NUSurface                     matlab.ui.control.NumericEditField
        PSurface                      matlab.ui.control.NumericEditField
        PoissonsRatioLabel            matlab.ui.control.Label
        MaterialEditFieldLabel_2      matlab.ui.control.Label
        ArrayTablesPanel              matlab.ui.container.Panel
        TablesGrid                    matlab.ui.container.GridLayout
        Elements                      matlab.ui.control.Table
        Nodes                         matlab.ui.control.Table
        PlotPanel                     matlab.ui.container.Panel
        PlotGrid                      matlab.ui.container.GridLayout
        DeformScale                   matlab.ui.control.NumericEditField
        DeformScaleEditFieldLabel     matlab.ui.control.Label
        HighlightE                    matlab.ui.control.StateButton
        LabelsE                       matlab.ui.control.StateButton
        ShowE                         matlab.ui.control.StateButton
        ShowN                         matlab.ui.control.StateButton
        HighlightN                    matlab.ui.control.StateButton
        LabelsN                       matlab.ui.control.StateButton
        Plot                          matlab.ui.control.StateButton
        ElementPropertiesPanel        matlab.ui.container.Panel
        ElementPropertiesGrid         matlab.ui.container.GridLayout
        MatElement                    matlab.ui.control.EditField
        MaterialEditFieldLabel        matlab.ui.control.Label
        EElement                      matlab.ui.control.NumericEditField
        GElement                      matlab.ui.control.NumericEditField
        PElement                      matlab.ui.control.NumericEditField
        DensitykgmLabel               matlab.ui.control.Label
        DElement                      matlab.ui.control.NumericEditField
        TElement                      matlab.ui.control.NumericEditField
        WallThicknessTLabel           matlab.ui.control.Label
        TubeDiameterDmLabel           matlab.ui.control.Label
        ShearModulusGLabel            matlab.ui.control.Label
        EYoungsModulusLabel           matlab.ui.control.Label
        ElementsPanel                 matlab.ui.container.Panel
        ElementsGrid                  matlab.ui.container.GridLayout
        FirstElement                  matlab.ui.control.Button
        SortElements                  matlab.ui.control.Button
        RemoveElement                 matlab.ui.control.Button
        AddElement                    matlab.ui.control.Button
        LastElement                   matlab.ui.control.Button
        NextElement                   matlab.ui.control.Button
        PreviousElement               matlab.ui.control.Button
        Node2                         matlab.ui.control.NumericEditField
        Node2EditFieldLabel           matlab.ui.control.Label
        Node1                         matlab.ui.control.NumericEditField
        Node1EditFieldLabel           matlab.ui.control.Label
        ElementNumber                 matlab.ui.control.NumericEditField
        ElementEditFieldLabel         matlab.ui.control.Label
        NodesPanel                    matlab.ui.container.Panel
        NodesGrid                     matlab.ui.container.GridLayout
        FirstNode                     matlab.ui.control.Button
        SortNodes                     matlab.ui.control.Button
        RemoveNode                    matlab.ui.control.Button
        AddNode                       matlab.ui.control.Button
        LastNode                      matlab.ui.control.Button
        NextNode                      matlab.ui.control.Button
        PreviousNode                  matlab.ui.control.Button
        FixedThetaz                   matlab.ui.control.StateButton
        FixedThetay                   matlab.ui.control.StateButton
        FixedThetax                   matlab.ui.control.StateButton
        Fixedz                        matlab.ui.control.StateButton
        Fixedy                        matlab.ui.control.StateButton
        Fixedx                        matlab.ui.control.StateButton
        FzLabel                       matlab.ui.control.Label
        Fz                            matlab.ui.control.NumericEditField
        FyLabel                       matlab.ui.control.Label
        Fy                            matlab.ui.control.NumericEditField
        FxLabel                       matlab.ui.control.Label
        Fx                            matlab.ui.control.NumericEditField
        ZLabel                        matlab.ui.control.Label
        Z                             matlab.ui.control.NumericEditField
        Y                             matlab.ui.control.NumericEditField
        YLabel                        matlab.ui.control.Label
        X                             matlab.ui.control.NumericEditField
        XLabel                        matlab.ui.control.Label
        NodeNumber                    matlab.ui.control.NumericEditField
        NodeEditFieldLabel            matlab.ui.control.Label
    end

    
    properties (Access = private)
        % Array for storing node data.
        n;
        Dn;
        % Array for storing element data.
        e;
        De;
        % For error checking
        E;
        % For saving the session file.
        savefile;
        % Loaded file
        Save;
        % Imported file
        Import;
        % FEA
        FEASolved;
        FEAVars;
        % Surface
        SN;
        SNS;
        SNLoaded;
        SurfaceSolved;
    end
    
    methods (Access = private)
        
        function [] = Update(app) % Updates app interface
            app.Nodes.Data = app.n;
            app.Elements.Data = app.e;
            DynamicNodesElements(app);
        end

        function [Error] = ErrorChecker(app)
            Error = 0; % Allows sequential error checking
            if ismember(10,app.E)
                % Load format error
                if isfield(app.Save,'NodeArray') == 0 && ...
                        isfield(app.Save,'ElementArray') == 0
                    Error = 1;
                    msg = 'Load file data corrupted';
                    title = 'ERROR';
                    uiconfirm(app.UIFigure,msg,title,'Options',{'OK'}, ...
                        'Icon','warning');
                end
            end
            if ismember(1,app.E) && Error == 0
                % Node array empty
                if isempty(app.n)
                    Error = 1;
                    msg = 'Node array is empty';
                    title = 'ERROR';
                    uiconfirm(app.UIFigure,msg,title,'Options',{'OK'},'Icon', ...
                        'warning');
                end
            end
            if ismember(2,app.E) && Error == 0
                % Element array empty
                if isempty(app.e)
                    Error = 1;
                    msg = 'Element array is empty';
                    title = 'ERROR';
                    uiconfirm(app.UIFigure,msg,title,'Options',{'OK'},'Icon', ...
                        'warning');
                end
            end
            if ismember(3,app.E) && Error == 0
                % Invalid node number
                if app.NodeNumber.Value <= 0
                    Error = 1;
                    msg = 'Invalid node';
                    title = 'ERROR';
                    uiconfirm(app.UIFigure,msg,title,'Options',{'OK'},'Icon', ...
                        'warning');
                end
            end
            if ismember(4,app.E) && Error == 0
                % Node number not allocated to node
                if app.NodeNumber.Value > height(app.n) || ...
                        app.NodeNumber.Value <= 0
                    Error = 1;
                    msg = 'This node does not exist.';
                    title = 'ERROR';
                    uiconfirm(app.UIFigure,msg,title,'Options',{'OK'},'Icon', ...
                        'warning');
                end
            end
            if ismember(5,app.E) && Error == 0
                % Invalid element number
                if app.ElementNumber.Value <= 0
                    Error = 1;
                    msg = 'Invalid element';
                    title = 'ERROR';
                    uiconfirm(app.UIFigure,msg,title,'Options',{'OK'}, ...
                        'Icon','warning');
                end
            end
            if ismember(6,app.E) && Error == 0
                % Element number not allocated to element
                if app.ElementNumber.Value > height(app.e) || ...
                        app.ElementNumber.Value <= 0
                    Error = 1;
                    msg = 'This element does not exist.';
                    title = 'ERROR';
                    uiconfirm(app.UIFigure,msg,title,'Options',{'OK'},'Icon', ...
                    'warning');
                end
            end
            if ismember(7,app.E) && Error == 0
                % Nodes required for element do not exist
                if isempty(find(app.n(:,1) == app.Node1.Value,1)) || ...
                        isempty(find(app.n(:,1) == app.Node2.Value,1))
                    Error = 1;
                    msg = 'One or more nodes do not exist';
                    title = 'ERROR';
                    uiconfirm(app.UIFigure,msg,title,'Options',{'OK'}, ...
                        'Icon','warning');
                end
            end
            if ismember(8,app.E) && Error == 0
                % Invalid nodes
                if ismember(0,app.e(:,2)) || ismember(0,app.e(:,3))
                    Error = 1;
                    msg = ['Invalid nodes in element array. Check for zeros' ...
                        ' in element array where nodes no longer exist.'];
                    title = 'ERROR';
                    uiconfirm(app.UIFigure,msg,title,'Options',{'OK'},'Icon', ...
                        'warning');
                end
            end
            if ismember(9,app.E) && Error == 0
                % Import format error
                if isfield(app.Import,'nodes') == 0
                    Error = 1;
                    msg = ['Imported file is not formatted correctly. ' ...
                        '"nodes" variable must exist with three columns: ' ...
                    'x, y, and z for each node''s coordinates.'];
                    title = 'ERROR';
                    uiconfirm(app.UIFigure,msg,title,'Options',{'OK'}, ...
                        'Icon','warning');
                end
            end
            if ismember(11,app.E) && Error == 0
                % Surface nodes not in truss
                nodes = app.Import.nodes(1:25,:);
                for i = 1:height(nodes)
                    if ismember(nodes(i,1),app.n(:,2)) && ...
                            ismember(nodes(i,2),app.n(:,3)) && ...
                            ismember(nodes(i,3),app.n(:,4))
                        ix = find(app.n(:,2) == nodes(i,1));
                        iy = find(app.n(:,3) == nodes(i,2));
                        iz = find(app.n(:,4) == nodes(i,3));
                        if isempty(intersect(intersect(ix,iy),iz))
                            Error = 1;
                        end
                    else
                        Error = 1;
                    end
                    if Error == 1
                        msg = ['Imported nodes do not wholly exist in the ' ...
                            'current truss structure, please check the node ' ...
                            'array and imported nodes for discrepancies'];
                        title = 'ERROR';
                        uiconfirm(app.UIFigure,msg,title,'Options',{'OK'}, ...
                            'Icon','warning');
                    end
                end
            end
            if ismember(12,app.E) && Error == 0
                % Mesh resolution is zero or negative
                if app.MeshResolution.Value <= 0
                    Error = 1;
                    msg = 'Mesh resolution cannot be negative or zero';
                    title = 'ERROR';
                    uiconfirm(app.UIFigure,msg,title,'Options',{'OK'}, ...
                        'Icon','warning');
                end
            end
        end

        function [] = Clear(app) % Clears only specific variables from session
            app.n = [];
            app.e = [];
            app.MatElement.Value = ('');
            app.EElement.Value = 0;
            app.GElement.Value = 0;
            app.PElement.Value = 0;
            app.DElement.Value = 0;
            app.TElement.Value = 0;
            app.MatSurface.Value = ('');
            app.MassSurface.Value = 0;
            app.ESurface.Value = 0;
            app.NUSurface.Value = 0;
            app.PSurface.Value = 0;
            app.Acceleration.Value = 1;
            app.MeshResolution.Value = 1;
            app.Surface.Value = 0;
        end

        function [] = SaveData(app) % Writes session variables to savefile
            % Nodes and elements
            NodeArray = app.n; ElementArray = app.e;
            % Element properties
            ElementMaterial = app.MatElement.Value; ElementE = app.EElement.Value;
            ElementG = app.GElement.Value; ElementP = app.PElement.Value;
            ElementD = app.DElement.Value; ElementT = app.TElement.Value;
            % Surface properties
            SurfaceMaterial = app.MatSurface.Value; SurfaceMass = app.MassSurface.Value;
            SurfaceE = app.ESurface.Value; SurfaceNU = app.NUSurface.Value;
            SurfaceP = app.PSurface.Value;
            % FEM Parameters
            GLoading = app.Acceleration.Value;
            Resolution = app.MeshResolution.Value;

            save(app.savefile,'NodeArray','ElementArray','ElementMaterial','ElementE', ...
                'ElementG','ElementP','ElementD','ElementT','SurfaceMaterial', ...
                'SurfaceMass','SurfaceE','SurfaceNU','SurfaceP','GLoading','Resolution');
        end

        function [] = LoadData(app) % Loads saved session variables
            [FILENAME,PATHNAME] = uigetfile('.mat','Load');
            if FILENAME ~= 0
                filename = append(PATHNAME,FILENAME);
                app.Save = load(filename);
                % Checking correct fields are in loaded structure.
                app.E = 10;
                Error = ErrorChecker(app);
                if Error == 0
                    Clear(app);
                    % Nodes and elements
                    app.n = app.Save.NodeArray; app.e = app.Save.ElementArray;
                    % Element properties
                    app.MatElement.Value = app.Save.ElementMaterial; app.EElement.Value = app.Save.ElementE;
                    app.GElement.Value = app.Save.ElementG; app.PElement.Value = app.Save.ElementP;
                    app.DElement.Value = app.Save.ElementD; app.TElement.Value = app.Save.ElementT;
                    % Surface properties
                    app.MatSurface.Value = app.Save.SurfaceMaterial; app.MassSurface.Value = app.Save.SurfaceMass;
                    app.ESurface.Value = app.Save.SurfaceE; app.NUSurface.Value = app.Save.SurfaceNU;
                    app.PSurface.Value = app.Save.SurfaceP;
                    % FEM Parameters
                    app.Acceleration.Value = app.Save.GLoading;
                    app.MeshResolution.Value = app.Save.Resolution;
                end
            end
        end

        function [] = ImportData(app)
            [FILENAME,PATHNAME] = uigetfile('.mat','Import');
            if FILENAME ~= 0
                filename = append(PATHNAME,FILENAME);
                app.Import = load(filename);
                % Checking "nodes" field is present in imported file.
                app.E = 9;
                Error = ErrorChecker(app);
                if Error == 0
                    app.n(:,2:4) = app.Import.nodes(:,:);
                    app.n(:,1) = zeros(height(app.n),1);
                    app.n(:,5:13) = zeros(height(app.n),9);
                    app.n(:,1) = 1:height(app.n);
                end
            end
        end

        function [] = AddNodeToArray(app)
            if isempty(app.n) == 1 || ...
                isempty(find(app.n(:,1) == app.NodeNumber.Value,1)) == 1
                app.n(height(app.n)+1,:) = ...
                [app.NodeNumber.Value,app.X.Value,app.Y.Value,app.Z.Value, ...
                app.Fixedx.Value,app.Fixedy.Value,app.Fixedz.Value, ...
                app.FixedThetax.Value,app.FixedThetay.Value, ...
                app.FixedThetaz.Value,app.Fx.Value,app.Fy.Value,app.Fz.Value];
            else
                app.n(find(app.n(:,1) == app.NodeNumber.Value),:) = ...
                [app.NodeNumber.Value,app.X.Value,app.Y.Value,app.Z.Value, ...
                app.Fixedx.Value,app.Fixedy.Value,app.Fixedz.Value, ...
                app.FixedThetax.Value,app.FixedThetay.Value, ...
                app.FixedThetaz.Value,app.Fx.Value,app.Fy.Value,app.Fz.Value];
            end
            if app.NodeNumber.Value == height(app.n)
                app.NodeNumber.Value = app.NodeNumber.Value+1;
            end
        end
        
        function [] = RemoveNodeFromArray(app)
            node = find(app.n(:,1) == app.NodeNumber.Value);
            app.n(node,:) = [];
            if isempty(app.e) == 0
            if isempty(intersect(app.e(:,2),app.NodeNumber.Value)) == 0
                app.e(find(app.e(:,2) == app.NodeNumber.Value),2) = 0;
            else
                if isempty(intersect(app.e(:,3),app.NodeNumber.Value)) == 0
                    app.e(find(app.e(:,3) == app.NodeNumber.Value),3) = 0;
                end
            end
            end
            if app.NodeNumber.Value == height(app.n)+1
                app.NodeNumber.Value = app.NodeNumber.Value-1;
            end
        end
        
        function [] = AddElementToArray(app)
            if isempty(app.e) == 1 || ...
                isempty(find(app.e(:,1) == app.ElementNumber.Value,1)) == 1
                app.e(height(app.e)+1,:) = ...
                [app.ElementNumber.Value,app.Node1.Value,app.Node2.Value];
            else
                app.e(find(app.e(:,1) == app.ElementNumber.Value),:) = ...
                [app.ElementNumber.Value,app.Node1.Value,app.Node2.Value];
            end
            if app.ElementNumber.Value == height(app.e)
                app.ElementNumber.Value = app.ElementNumber.Value+1;
            end
        end
        
        function [] = RemoveElementFromArray(app)
            element = find(app.e(:,1) == app.ElementNumber.Value);
            app.e(element,:) = [];
            if app.ElementNumber.Value == height(app.e)+1
                app.ElementNumber.Value = app.ElementNumber.Value-1;
            end
        end
        
        function [] = DynamicNodesElements(app)
            if isempty(app.n) == 0
                if isempty(find(app.n(:,1) == app.NodeNumber.Value,1)) == 0
                    node = find(app.n(:,1) == app.NodeNumber.Value,1);
                    app.X.Value = app.n(node,2);
                    app.Y.Value = app.n(node,3);
                    app.Z.Value = app.n(node,4);
                    app.Fixedx.Value = app.n(node,5);
                    app.Fixedy.Value = app.n(node,6);
                    app.Fixedz.Value = app.n(node,7);
                    app.FixedThetax.Value = app.n(node,8);
                    app.FixedThetay.Value = app.n(node,9);
                    app.FixedThetaz.Value = app.n(node,10);
                    app.Fx.Value = app.n(node,11);
                    app.Fy.Value = app.n(node,12);
                    app.Fz.Value = app.n(node,13);
                else
                    app.X.Value = 0;
                    app.Y.Value = 0;
                    app.Z.Value = 0;
                    app.Fixedx.Value = 0;
                    app.Fixedy.Value = 0;
                    app.Fixedz.Value = 0;
                    app.FixedThetax.Value = 0;
                    app.FixedThetax.Value = 0;
                    app.FixedThetax.Value = 0;
                    app.Fx.Value = 0;
                    app.Fy.Value = 0;
                    app.Fz.Value = 0;
                end
            end
            if isempty(app.e) == 0
                if isempty(find(app.e(:,1) == app.ElementNumber.Value,1)) == 0
                    element = find(app.e(:,1) == app.ElementNumber.Value,1);
                    app.Node1.Value = app.e(element,2);
                    app.Node2.Value = app.e(element,3);
                else
                    app.Node1.Value = 0;
                    app.Node2.Value = 0;
                end
            end
        end
        
        function [] = SpaceFramePlot(app)
            if app.Plot.Value == 1
                app.E = [1,2,8];
                Error = ErrorChecker(app);
                if Error == 0
                    [az,el] = view;
                    clf(figure(1))
                    hold on
                    xlabel('x (m)');
                    ylabel('y (m)');
                    zlabel('z (m)');
                    if app.ShowN.Value == 1
                        w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Plotting nodes');
                        for i = 1:height(app.n)
                            w.Value = i/height(app.n);
                            plot3(app.n(i,2),app.n(i,3),app.n(i,4),'ok');
                            if app.LabelsN.Value == 1
                                label = num2str(app.n(i,1));
                                x = app.n(i,2)+0.1;
                                y = app.n(i,3)+0.1;
                                z = app.n(i,4)+0.1;
                                text(x,y,z,label);
                            end
                        end
                        if app.HighlightN.Value == 1
                            plot3(app.n(find(app.n(:,1) == app.NodeNumber.Value,1),2), ...
                                app.n(find(app.n(:,1) == app.NodeNumber.Value,1),3), ...
                                app.n(find(app.n(:,1) == app.NodeNumber.Value,1),4), ...
                                'or');
                        end
                        close(w)
                    end
                    if app.ShowE.Value == 1
                        w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Plotting elements');
                        for i = 1:height(app.e)
                            w.Value = i/height(app.e);
                            plot3([app.n(find(app.n(:,1) == app.e(i,2),1),2), ...
                                app.n(find(app.n(:,1) == app.e(i,3),1),2)], ...
                                [app.n(find(app.n(:,1) == app.e(i,2),1),3), ...
                                app.n(find(app.n(:,1) == app.e(i,3),1),3)], ...
                                [app.n(find(app.n(:,1) == app.e(i,2),1),4), ...
                                app.n(find(app.n(:,1) == app.e(i,3),1),4)], ...
                                '-k');
                            if app.LabelsE.Value == 1
                                label = num2str(app.e(i,1));
                                x = (app.n(find(app.n(:,1) == app.e(i,2),1),2) + ...
                                        app.n(find(app.n(:,1) == app.e(i,3),1),2))/2 ...
                                        + 0.1;
                                y = (app.n(find(app.n(:,1) == app.e(i,2),1),3) + ...
                                        app.n(find(app.n(:,1) == app.e(i,3),1),3))/2 ...
                                        + 0.1;
                                z = (app.n(find(app.n(:,1) == app.e(i,2),1),4) + ...
                                        app.n(find(app.n(:,1) == app.e(i,3),1),4))/2 ...
                                        + 0.1;
                                text(x,y,z,label);
                            end
                        end
                        if app.HighlightE.Value == 1
                            plot3([app.n(find(app.n(:,1) == app.e(find(app.e(:,1) == app.ElementNumber.Value,1),2),1),2), ...
                                app.n(find(app.n(:,1) == app.e(find(app.e(:,1) == app.ElementNumber.Value,1),3),1),2)], ...
                                [app.n(find(app.n(:,1) == app.e(find(app.e(:,1) == app.ElementNumber.Value,1),2),1),3), ...
                                app.n(find(app.n(:,1) == app.e(find(app.e(:,1) == app.ElementNumber.Value,1),3),1),3)], ...
                                [app.n(find(app.n(:,1) == app.e(find(app.e(:,1) == app.ElementNumber.Value,1),2),1),4), ...
                                app.n(find(app.n(:,1) == app.e(find(app.e(:,1) == app.ElementNumber.Value,1),3),1),4)], ...
                                '-r');
                        end
                        close(w)
                    end
                view(az,el)
                end
            else
                close(figure(1))
            end
        end

        function [] = FEAPlot(app)
            if app.FEASolved == 1 && app.PlotFEA.Value == 1
                [az,el] = view;
                clf(figure(2))
                hold on
                xlabel('x (m)');
                ylabel('y (m)');
                zlabel('z (m)');
                if app.Undeflected.Value == 1
                    %% Space Frame Deflection Plot (Undeflected)
                    w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Plotting undeflected space frame');
                    for i = 1:height(app.De)
                        w.Value = i/height(app.De);
                        plot3([app.Dn(find(app.Dn(:,1) == app.De(i,2),1),2), ...
                        app.Dn(find(app.Dn(:,1) == app.De(i,3),1),2)], ...
                        [app.Dn(find(app.Dn(:,1) == app.De(i,2),1),3), ...
                        app.Dn(find(app.Dn(:,1) == app.De(i,3),1),3)], ...
                        [app.Dn(find(app.Dn(:,1) == app.De(i,2),1),4), ...
                        app.Dn(find(app.Dn(:,1) == app.De(i,3),1),4)], ...
                        '-k');
                    end
                    close(w)
                end

                %% Space Frame Deflection Plot (Deflected)
                % Replots the elements + their deflection values to
                % visually show the deflected structure
                ds = app.DeformScale.Value;
                w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Plotting deflected space frame');
                for i = 1:height(app.De)
                    w.Value = i/height(app.De);
                    if app.FEAVars.sigx(find(app.De(:,1) == i,1)) > 0 % Tension
                        colour = 'blue';
                    else
                        if app.FEAVars.sigx(find(app.De(:,1) == i,1)) == 0 % Neutral
                            colour = 'green';
                        else
                        end
                        if app.FEAVars.sigx(find(app.De(:,1) == i,1)) < 0 % Compression
                            colour = 'red';
                        end
                    end
                    plot3([app.Dn(find(app.Dn(:,1) == app.De(i,2),1),2)+app.FEAVars.U(6*(app.De(i,2)-1)+1)*ds, ...
                    app.Dn(find(app.Dn(:,1) == app.De(i,3),1),2)+app.FEAVars.U(6*(app.De(i,3)-1)+1)*ds], ...
                    [app.Dn(find(app.Dn(:,1) == app.De(i,2),1),3)+app.FEAVars.U(6*(app.De(i,2)-1)+2)*ds, ...
                    app.Dn(find(app.Dn(:,1) == app.De(i,3),1),3)+app.FEAVars.U(6*(app.De(i,3)-1)+2)*ds], ...
                    [app.Dn(find(app.Dn(:,1) == app.De(i,2),1),4)+app.FEAVars.U(6*(app.De(i,2)-1)+3)*ds, ...
                    app.Dn(find(app.Dn(:,1) == app.De(i,3),1),4)+app.FEAVars.U(6*(app.De(i,3)-1)+3)*ds], ...
                        'Color',colour);
                end
                close(w)
                view(az,el)
            else
                close(figure(2))
            end
        end

        function [] = SurfacePlot(app)
            if app.SurfaceSolved == 1 && app.PlotSurface.Value == 1
                clf(figure(3))
                subplot(1,2,1)
                mesh(app.FEAVars.xq,app.FEAVars.yq,app.FEAVars.wq)
                hold on
                plot3(app.FEAVars.x,app.FEAVars.y,app.FEAVars.w,'o')
                title('Surface Deflection')
                xlabel('x (m)')
                ylabel('y (m)')
                zlabel('Deflection (m)')
                subplot(1,2,2)
                contourf(app.FEAVars.xq,app.FEAVars.yq, ...
                    app.FEAVars.sigVM/1e6,100,'LineColor','none')
                axis equal
                hold on
                c = colorbar;
                title('von Mises stress on top surface')
                xlabel('x (m)')
                ylabel('y (m)')
                ylabel(c,'Stress (MPa)')
            else
                close(figure(3))
            end
        end

        function [] = FEMSolver(app)
            app.E = [1,2,8,12];
            Error = ErrorChecker(app);
            if Error == 0
                %% Importing Nodes for Surface
                if app.Surface.Value == 1
                    msg = 'Please select ".mat" file containing surface node coordinates';
                    title = 'Import';
                    selection = uiconfirm(app.UIFigure,msg,title,'Options',{'OK'},'Icon', ...
                        'file_open.png');
                    if contains(selection,'OK')
                    [FILENAME,PATHNAME] = uigetfile('.mat','Import');
                        if FILENAME ~= 0
                            filename = append(PATHNAME,FILENAME);
                            app.Import = load(filename);
                            Imported = 1;
                        end
                    else
                        Imported = 0;
                    end

                    %% Node Allocation
                    % Checking "nodes" field is present in imported file
                    % Checking surface nodes exist in space frame
                    app.E = [9,11];
                    Error = ErrorChecker(app);
                    if Error == 0 && Imported == 1
                        nodes = app.Import.nodes(1:25,:); % 1:25 specifically for mirror file
                        SurfaceNodes = zeros(height(nodes),1);
                        for i = 1:height(nodes)
                            ix = find(app.n(:,2) == nodes(i,1));
                            iy = find(app.n(:,3) == nodes(i,2));
                            iz = find(app.n(:,4) == nodes(i,3));
                            SurfaceNodes(i) = intersect(intersect(ix,iy),iz);
                        end
                        app.SN = SurfaceNodes;
                        app.SNS = [];
                        app.SNLoaded = 1;
                    end
                end

                %% Mesh Resolution
                W = uiprogressdlg(app.UIFigure,'Title', ...
                    'Solving FEA','Indeterminate','on');
                Res = app.MeshResolution.Value - 1;
                inodes = zeros(Res*height(app.e),13);
                ielements = zeros((Res+1)*height(app.e),3);
                w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Resolving mesh');
                for i = 1:height(app.e)
                    w.Value = i/height(app.e);
                    for j = 1:Res
                        % Intermediate nodes
                        p1 = app.n(find(app.n(:,1) == app.e(i,2),1),2:4);
                        p2 = app.n(find(app.n(:,1) == app.e(i,3),1),2:4);
                        x = p1(1) + j*((p2(1)-p1(1))/(Res+1));
                        y = p1(2) + j*((p2(2)-p1(2))/(Res+1));
                        z = p1(3) + j*((p2(3)-p1(3))/(Res+1));
                        inodes((i-1)*Res+j,:) = [1/(2*((i-1)*Res+j)),x,y,z,0,0,0,0,0,0,0,0,0];
                    end
                    ielements((i-1)*(Res+1)+1,1:2) = [(i-1)*(Res+1)+1,app.e(i,2)];
                    for j = 1:Res
                        ielements((i-1)*(Res+1)+j,3) = inodes(Res*(i-1)+j,1);
                        ielements((i-1)*(Res+1)+j+1,1:2) = [(i-1)*Res+j+1,inodes(Res*(i-1)+j,1)];
                    end
                    ielements(i*(Res+1),3) = app.e(i,3);
                end
                close(w)
                app.Dn = [app.n;inodes];
                app.De = ielements;
                % Reconfigure arrays
                app.Dn = sortrows(app.Dn,[2,3,4,5,6,7]);
                if app.SNLoaded == 1
                    if isempty(app.SNS)
                        for i = 1:height(app.SN)
                            app.SN(i) = find(app.Dn(:,1) == app.SN(i),1);
                            app.SNS = 1;
                        end
                    end
                end
                for i = 1:height(app.De)
                    app.De(i,2) = find(app.Dn(:,1) == app.De(i,2),1);
                    app.De(i,3) = find(app.Dn(:,1) == app.De(i,3),1);
                end
                app.Dn(:,1) = 1:height(app.Dn);

                %% Element Variable Setup
                E = app.EElement.Value*1e9; % Young's modulus
                G = app.GElement.Value*1e9; % Shear modulus
                P = app.PElement.Value*1000; % Density
                D = app.DElement.Value/1e3; % Tube diameter
                T = app.TElement.Value/1e3; % Tube wall thickness
                A = (pi/4)*(D^2-(D-2*T)^2); % Tube area
                Iy = (pi/64)*(D^4-(D-2*T)^4); % Second moment of area
                Iz = Iy;
                J = (pi/32)*(D^4-(D-2*T)^4); % Polar moment
                m = (pi/4)*(D^2-(D-2*T)^2)*P; % Mass per unit length

                %% Surface Variable Setup
                MS = app.MassSurface.Value; % Mass
                ES = app.ESurface.Value*1e9; % Young's modulus
                NU = app.NUSurface.Value; % Poisson's ratio
                PS = app.PSurface.Value*1000; % Density
                Accel = app.Acceleration.Value*9.81; % "g" loading
                TS = (MS/PS)/(pi*4); % Thickness (Specific to a 4 metre diameter disc)

                %% Surface Force Calculation
                % The surface node array is used to find the corresponding
                % nodes in the main node array, then the Fz value for these
                % nodes are set by dividing the total surface mass by the
                % number of nodes, then multiplying these individual masses
                % by the g loading.
                if app.SNLoaded == 1
                    for i = 1:height(app.SN)
                        app.Dn(find(app.Dn(:,1) == app.SN(i),1),13) = ...
                            app.Dn(find(app.Dn(:,1) == app.SN(i),1),13) + ...
                            (-MS*Accel)/height(app.SN);
                    end
                end

                %% FEA Solution
                n = app.Dn;
                e = app.De;
                [F,M] = GlobalForceVector(n,e,m);
                k = SpaceFrameElementStiffnessMatrix(E,G,A,Iy,Iz,J,n,e);
                K = SpaceFrameGlobalStiffnessMatrix(k,n,e);
                [KB,FB] = BoundaryConditions(K,F,n);
                [U,NF] = NodalDisplacements(K,KB,FB,n);
                [EF,sigx,My,Mz] = ElementInternalAnalysis(E,G,A,Iy,Iz,J,U,n,e);
                app.FrameMass.Value = M;
                app.FEAVars.sigx = sigx;
                app.FEAVars.U = U;

                %% von Mises Stress Calculations
                for i = 1:height(e)
                    Fx = EF(i,7); % Axial internal force
                    sigX1_1 = Fx/A+sqrt(((EF(i,6)*D)/J)^2+((EF(i,5)*D)/J)^2); % Axial stress
                    sigX1_2 = Fx/A-sqrt(((EF(i,6)*D)/J)^2+((EF(i,5)*D)/J)^2);
                    sigX2_1 = Fx/A+sqrt(((EF(i,12)*D)/J)^2+((EF(i,11)*D)/J)^2);
                    sigX2_2 = Fx/A-sqrt(((EF(i,12)*D)/J)^2+((EF(i,11)*D)/J)^2);
                    tauX = (abs(EF(i,4))*D)/(2*J); % Shear stress
                    sigVM1_1 = sqrt(sigX1_1^2+3*tauX^2); % von Mises stress
                    sigVM1_2 = sqrt(sigX1_2^2+3*tauX^2);
                    sigVM2_1 = sqrt(sigX2_1^2+3*tauX^2);
                    sigVM2_2 = sqrt(sigX2_2^2+3*tauX^2);
                    sigVMMax(i) = max([sigVM1_1,sigVM1_2,sigVM2_1,sigVM2_2]);
                end
                sigVMMAX = max(sigVMMax);
                app.MaxVM.Value = sigVMMAX/1e6;

                %% Maximum Node Deflection
                u = zeros(height(U)/2,1);
                for i = 1:height(U)/6
                    for j = 1:3
                        u((i-1)*3+j) = U((i-1)*6+j);
                    end
                end
                app.MaxDeflect.Value = max(abs(u));

                %% Surface Deformation Variables
                if app.Surface.Value == 1 && app.SNLoaded == 1
                    x = zeros(height(app.SN),1);
                    y = zeros(height(app.SN),1);
                    w = zeros(height(app.SN),1);
                    for i = 1:(height(app.SN))
                        x(i) = app.Dn(app.SN(i),2);
                        y(i) = app.Dn(app.SN(i),3);
                        w(i) = U((app.SN(i)-1)*6+3);
                    end

                    %% Grid Interpolation
                    h = 0.1;
                    [xq,yq] = meshgrid(-2:h:2, -2:h:2);
                    wq = griddata(x,y,w,xq,yq,'v4');

                    [gradX,gradY] = gradient(wq,h);
                    [curvXX,curvXY] = gradient(gradX,h);
                    [~,curvYY] = gradient(gradY,h);

                    %% Stresses
                    sigX = -ES/(1 - NU^2)*TS/2*(curvXX + NU.*curvYY);
                    sigY = -ES/(1 - NU^2)*TS/2*(NU*curvXX + curvYY);
                    tauXY = -ES/(1 - NU^2)*TS/2*(1 - NU)*curvXY;
                    sigVM = sqrt(1/2*((sigX - sigY).^2 + (sigY - 0).^2 + (0 - sigX).^2) ...
                        + 3*(tauXY.^2 + 0 + 0));

                    %% Exporting Variables
                    app.FEAVars.x = x;
                    app.FEAVars.y = y;
                    app.FEAVars.w = w;
                    app.FEAVars.xq = xq;
                    app.FEAVars.yq = yq;
                    app.FEAVars.wq = wq;
                    app.FEAVars.sigVM = sigVM;
                    app.SurfaceThickness.Value = TS*1e3;
                    app.SigmaMax.Value = max(sigVM,[],'all')/1e6;

                    %% Enabling Surface Plot
                    app.SurfaceSolved = 1;
                    app.PlotSurfaceValueChanged;
                end
                close(W)
                %% Enabling FEM Plot
                app.FEASolved = 1;
                app.PlotFEAValueChanged;
            end

            function [k] = SpaceFrameElementStiffnessMatrix(E,G,A,Iy,Iz,J,n,e)
            %SpaceFrameElementStiffnessMatrix Compiles 3D element stiffness array.
            %   This function uses the SpaceFrameElementStiffness function to compile
            %   a 3D matrix comprised of all the individual element stiffness matrices 
            %   for the node array 'n' and element array 'e'.
            k = zeros(12,12,height(e));
            w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Compiling element stiffness matrices');
            for i = 1:height(e)
                w.Value = i/height(e);
                k(:,:,i) = SpaceFrameElementStiffness(E,G,A,Iy,Iz,J, ...
                    n(e(i,2),2),n(e(i,2),3),n(e(i,2),4),n(e(i,3),2), ...
                    n(e(i,3),3),n(e(i,3),4));
            end
            close(w)
            end
        
            function [y] = SpaceFrameElementStiffness(E,G,A,Iy,Iz,J,x1,y1,z1,x2,y2,z2)
            %SpaceFrameElementStiffness   This function returns the element 
            %                             stiffness matrix for a space frame   
            %                             element with modulus of elasticity E,  
            %                             shear modulus of elasticity G, cross-
            %                             sectional area A, moments of inertia 
            %                             Iy and Iz, torsional constant J, 
            %                             coordinates (x1,y1,z1) for the first 
            %                             node and coordinates (x2,y2,z2) for the
            %                             second node.
            %                             The size of the element stiffness 
            %                             matrix is 12 x 12.
            L = sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1));
            w1 = E*A/L;
            w2 = 12*E*Iz/(L*L*L);
            w3 = 6*E*Iz/(L*L);
            w4 = 4*E*Iz/L;
            w5 = 2*E*Iz/L;
            w6 = 12*E*Iy/(L*L*L);
            w7 = 6*E*Iy/(L*L);
            w8 = 4*E*Iy/L;
            w9 = 2*E*Iy/L;
            w10 = G*J/L;
            kprime = [w1 0 0 0 0 0 -w1 0 0 0 0 0 ;
                0 w2 0 0 0 w3 0 -w2 0 0 0 w3 ;
                0 0 w6 0 -w7 0 0 0 -w6 0 -w7 0 ;
                0 0 0 w10 0 0 0 0 0 -w10 0 0 ;
                0 0 -w7 0 w8 0 0 0 w7 0 w9 0 ;
                0 w3 0 0 0 w4 0 -w3 0 0 0 w5 ;
                -w1 0 0 0 0 0 w1 0 0 0 0 0 ;
                0 -w2 0 0 0 -w3 0 w2 0 0 0 -w3 ;
                0 0 -w6 0 w7 0 0 0 w6 0 w7 0 ;
                0 0 0 -w10 0 0 0 0 0 w10 0 0 ;
                0 0 -w7 0 w9 0 0 0 w7 0 w8 0 ;
                0 w3 0 0 0 w5 0 -w3 0 0 0 w4];
            if x1 == x2 & y1 == y2
                if z2 > z1
                    Lambda = [0 0 1 ; 0 1 0 ; -1 0 0];
                else
                    Lambda = [0 0 -1 ; 0 1 0 ; 1 0 0];
                end
            else
                CXx = (x2-x1)/L;
	            CYx = (y2-y1)/L;
	            CZx = (z2-z1)/L;
	            D = sqrt(CXx*CXx + CYx*CYx);
	            CXy = -CYx/D;
	            CYy = CXx/D;
	            CZy = 0;
	            CXz = -CXx*CZx/D;
	            CYz = -CYx*CZx/D;
	            CZz = D;
	            Lambda = [CXx CYx CZx ; CXy CYy CZy ; CXz CYz CZz];
            end
            R = [Lambda zeros(3) zeros(3) zeros(3) ; 
            zeros(3) Lambda zeros(3) zeros(3) ;
            zeros(3) zeros(3) Lambda zeros(3) ;
            zeros(3) zeros(3) zeros(3) Lambda];
            y = R'*kprime*R;   
            end
        
            function [F,M] = GlobalForceVector(n,e,m)
            %GLOBALFORCEVECTOR Compiles global force vector from data in 'n' array
            %   This function compiles the individual Fx, Fy and Fz forces for each
            %   node into the global force vector.
            F = zeros(height(n)*6,1);
            w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Compiling force vector');
            for i = 1:height(n)
                w.Value = i/height(n);
                F([6*(i-1)+1;6*(i-1)+2;6*(i-1)+3]) = [n(i,11),n(i,12),n(i,13)];
            end
            close(w)
            L = zeros(height(e),1); % Element length array
            Lx = zeros(height(e),1); % Projected x
            Ly = zeros(height(e),1); % Projected y
            M = 0; % Mass
            w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Calculating element lengths');
            for i = 1:height(e)
                w.Value = i/height(e);
                dx = n(find(n(:,1) == e(i,3),1),2)- ...
                    n(find(n(:,1) == e(i,2),1),2);
                dy = n(find(n(:,1) == e(i,3),1),3)- ...
                    n(find(n(:,1) == e(i,2),1),3);
                dz = n(find(n(:,1) == e(i,3),1),4)- ...
                    n(find(n(:,1) == e(i,2),1),4);
                L(i) = sqrt(dx^2+dy^2+dz^2);
                Lx(i) = dx;
                Ly(i) = dy;
                M = M + m*L(i);
            end
            close(w)
            qz = m*(-Accel); % Force per unit length
            w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Distributing loads');
            for i = 1:height(e)
                w.Value = i/height(e);
%               F(6 * (index of node in "n" array - 1) + 3) = Fz1
                F(6*((find(n(:,1) == e(i,2),1))-1)+3) = ...
                    F(6*((find(n(:,1) == e(i,2),1))-1)+3) + ...
                    qz*L(i)*(1/2);
%               F(6 * (index of node in "n" array - 1) + 4) = Mx1 
                F(6*((find(n(:,1) == e(i,2),1))-1)+4) = ...
                    F(6*((find(n(:,1) == e(i,2),1))-1)+4) + ...
                    qz*L(i)*(Lx(i)/12);                        
%               F(6 * (index of node in "n" array - 1) + 5) = My1
                F(6*((find(n(:,1) == e(i,2),1))-1)+5) = ...
                    F(6*((find(n(:,1) == e(i,2),1))-1)+5) + ...
                    qz*L(i)*(Ly(i)/12);                         
                F(6*((find(n(:,1) == e(i,3),1))-1)+3) = ...     % Fz2
                    F(6*((find(n(:,1) == e(i,3),1))-1)+3) + ...
                    qz*L(i)*(1/2);                              
                F(6*((find(n(:,1) == e(i,3),1))-1)+4) = ...     % Mx2
                    F(6*((find(n(:,1) == e(i,3),1))-1)+4) + ...
                    -qz*L(i)*(Lx(i)/12);                        
                F(6*((find(n(:,1) == e(i,3),1))-1)+5) = ...     % My2
                    F(6*((find(n(:,1) == e(i,3),1))-1)+5) + ...
                    -qz*L(i)*(Ly(i)/12);                        
            end
            close(w)
            end
        
            function [K] = SpaceFrameGlobalStiffnessMatrix(k,n,e)
            %SpaceFrameGlobalStiffnessMatrix Compiles global stiffness matrix.
            %   This function uses the SpaceFrameAssemble function to compile the
            %   global stiffness matrix from the element stiffness matrices, according
            %   to the space frame construction defined by the element array 'e'.
            K = zeros(height(n)*6);
            w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Assembling Global Stiffness Matrix');
            for i = 1:height(e)
                w.Value = i/height(e);
                K = SpaceFrameAssemble(K,k(:,:,i),e(i,2),e(i,3));
            end
            close(w)
            end
        
            function [y] = SpaceFrameAssemble(K,k,i,j)
            %SpaceFrameAssemble   This function assembles the element stiffness
            %                     matrix k of the space frame element with nodes
            %                     i and j into the global stiffness matrix K.
            %                     This function returns the global stiffness  
            %                     matrix K after the element stiffness matrix  
            %                     k is assembled.
            K(6*i-5,6*i-5) = K(6*i-5,6*i-5) + k(1,1);
            K(6*i-5,6*i-4) = K(6*i-5,6*i-4) + k(1,2);
            K(6*i-5,6*i-3) = K(6*i-5,6*i-3) + k(1,3);
            K(6*i-5,6*i-2) = K(6*i-5,6*i-2) + k(1,4);
            K(6*i-5,6*i-1) = K(6*i-5,6*i-1) + k(1,5);
            K(6*i-5,6*i) = K(6*i-5,6*i) + k(1,6);
            K(6*i-5,6*j-5) = K(6*i-5,6*j-5) + k(1,7);
            K(6*i-5,6*j-4) = K(6*i-5,6*j-4) + k(1,8);
            K(6*i-5,6*j-3) = K(6*i-5,6*j-3) + k(1,9);
            K(6*i-5,6*j-2) = K(6*i-5,6*j-2) + k(1,10);
            K(6*i-5,6*j-1) = K(6*i-5,6*j-1) + k(1,11);
            K(6*i-5,6*j) = K(6*i-5,6*j) + k(1,12);
            K(6*i-4,6*i-5) = K(6*i-4,6*i-5) + k(2,1);
            K(6*i-4,6*i-4) = K(6*i-4,6*i-4) + k(2,2);
            K(6*i-4,6*i-3) = K(6*i-4,6*i-3) + k(2,3);
            K(6*i-4,6*i-2) = K(6*i-4,6*i-2) + k(2,4);
            K(6*i-4,6*i-1) = K(6*i-4,6*i-1) + k(2,5);
            K(6*i-4,6*i) = K(6*i-4,6*i) + k(2,6);
            K(6*i-4,6*j-5) = K(6*i-4,6*j-5) + k(2,7);
            K(6*i-4,6*j-4) = K(6*i-4,6*j-4) + k(2,8);
            K(6*i-4,6*j-3) = K(6*i-4,6*j-3) + k(2,9);
            K(6*i-4,6*j-2) = K(6*i-4,6*j-2) + k(2,10);
            K(6*i-4,6*j-1) = K(6*i-4,6*j-1) + k(2,11);
            K(6*i-4,6*j) = K(6*i-4,6*j) + k(2,12);
            K(6*i-3,6*i-5) = K(6*i-3,6*i-5) + k(3,1);
            K(6*i-3,6*i-4) = K(6*i-3,6*i-4) + k(3,2);
            K(6*i-3,6*i-3) = K(6*i-3,6*i-3) + k(3,3);
            K(6*i-3,6*i-2) = K(6*i-3,6*i-2) + k(3,4);
            K(6*i-3,6*i-1) = K(6*i-3,6*i-1) + k(3,5);
            K(6*i-3,6*i) = K(6*i-3,6*i) + k(3,6);
            K(6*i-3,6*j-5) = K(6*i-3,6*j-5) + k(3,7);
            K(6*i-3,6*j-4) = K(6*i-3,6*j-4) + k(3,8);
            K(6*i-3,6*j-3) = K(6*i-3,6*j-3) + k(3,9);
            K(6*i-3,6*j-2) = K(6*i-3,6*j-2) + k(3,10);
            K(6*i-3,6*j-1) = K(6*i-3,6*j-1) + k(3,11);
            K(6*i-3,6*j) = K(6*i-3,6*j) + k(3,12);
            K(6*i-2,6*i-5) = K(6*i-2,6*i-5) + k(4,1);
            K(6*i-2,6*i-4) = K(6*i-2,6*i-4) + k(4,2);
            K(6*i-2,6*i-3) = K(6*i-2,6*i-3) + k(4,3);
            K(6*i-2,6*i-2) = K(6*i-2,6*i-2) + k(4,4);
            K(6*i-2,6*i-1) = K(6*i-2,6*i-1) + k(4,5);
            K(6*i-2,6*i) = K(6*i-2,6*i) + k(4,6);
            K(6*i-2,6*j-5) = K(6*i-2,6*j-5) + k(4,7);
            K(6*i-2,6*j-4) = K(6*i-2,6*j-4) + k(4,8);
            K(6*i-2,6*j-3) = K(6*i-2,6*j-3) + k(4,9);
            K(6*i-2,6*j-2) = K(6*i-2,6*j-2) + k(4,10);
            K(6*i-2,6*j-1) = K(6*i-2,6*j-1) + k(4,11);
            K(6*i-2,6*j) = K(6*i-2,6*j) + k(4,12);
            K(6*i-1,6*i-5) = K(6*i-1,6*i-5) + k(5,1);
            K(6*i-1,6*i-4) = K(6*i-1,6*i-4) + k(5,2);
            K(6*i-1,6*i-3) = K(6*i-1,6*i-3) + k(5,3);
            K(6*i-1,6*i-2) = K(6*i-1,6*i-2) + k(5,4);
            K(6*i-1,6*i-1) = K(6*i-1,6*i-1) + k(5,5);
            K(6*i-1,6*i) = K(6*i-1,6*i) + k(5,6);
            K(6*i-1,6*j-5) = K(6*i-1,6*j-5) + k(5,7);
            K(6*i-1,6*j-4) = K(6*i-1,6*j-4) + k(5,8);
            K(6*i-1,6*j-3) = K(6*i-1,6*j-3) + k(5,9);
            K(6*i-1,6*j-2) = K(6*i-1,6*j-2) + k(5,10);
            K(6*i-1,6*j-1) = K(6*i-1,6*j-1) + k(5,11);
            K(6*i-1,6*j) = K(6*i-1,6*j) + k(5,12);
            K(6*i,6*i-5) = K(6*i,6*i-5) + k(6,1);
            K(6*i,6*i-4) = K(6*i,6*i-4) + k(6,2);
            K(6*i,6*i-3) = K(6*i,6*i-3) + k(6,3);
            K(6*i,6*i-2) = K(6*i,6*i-2) + k(6,4);
            K(6*i,6*i-1) = K(6*i,6*i-1) + k(6,5);
            K(6*i,6*i) = K(6*i,6*i) + k(6,6);
            K(6*i,6*j-5) = K(6*i,6*j-5) + k(6,7);
            K(6*i,6*j-4) = K(6*i,6*j-4) + k(6,8);
            K(6*i,6*j-3) = K(6*i,6*j-3) + k(6,9);
            K(6*i,6*j-2) = K(6*i,6*j-2) + k(6,10);
            K(6*i,6*j-1) = K(6*i,6*j-1) + k(6,11);
            K(6*i,6*j) = K(6*i,6*j) + k(6,12);
            K(6*j-5,6*i-5) = K(6*j-5,6*i-5) + k(7,1);
            K(6*j-5,6*i-4) = K(6*j-5,6*i-4) + k(7,2);
            K(6*j-5,6*i-3) = K(6*j-5,6*i-3) + k(7,3);
            K(6*j-5,6*i-2) = K(6*j-5,6*i-2) + k(7,4);
            K(6*j-5,6*i-1) = K(6*j-5,6*i-1) + k(7,5);
            K(6*j-5,6*i) = K(6*j-5,6*i) + k(7,6);
            K(6*j-5,6*j-5) = K(6*j-5,6*j-5) + k(7,7);
            K(6*j-5,6*j-4) = K(6*j-5,6*j-4) + k(7,8);
            K(6*j-5,6*j-3) = K(6*j-5,6*j-3) + k(7,9);
            K(6*j-5,6*j-2) = K(6*j-5,6*j-2) + k(7,10);
            K(6*j-5,6*j-1) = K(6*j-5,6*j-1) + k(7,11);
            K(6*j-5,6*j) = K(6*j-5,6*j) + k(7,12);
            K(6*j-4,6*i-5) = K(6*j-4,6*i-5) + k(8,1);
            K(6*j-4,6*i-4) = K(6*j-4,6*i-4) + k(8,2);
            K(6*j-4,6*i-3) = K(6*j-4,6*i-3) + k(8,3);
            K(6*j-4,6*i-2) = K(6*j-4,6*i-2) + k(8,4);
            K(6*j-4,6*i-1) = K(6*j-4,6*i-1) + k(8,5);
            K(6*j-4,6*i) = K(6*j-4,6*i) + k(8,6);
            K(6*j-4,6*j-5) = K(6*j-4,6*j-5) + k(8,7);
            K(6*j-4,6*j-4) = K(6*j-4,6*j-4) + k(8,8);
            K(6*j-4,6*j-3) = K(6*j-4,6*j-3) + k(8,9);
            K(6*j-4,6*j-2) = K(6*j-4,6*j-2) + k(8,10);
            K(6*j-4,6*j-1) = K(6*j-4,6*j-1) + k(8,11);
            K(6*j-4,6*j) = K(6*j-4,6*j) + k(8,12);
            K(6*j-3,6*i-5) = K(6*j-3,6*i-5) + k(9,1);
            K(6*j-3,6*i-4) = K(6*j-3,6*i-4) + k(9,2);
            K(6*j-3,6*i-3) = K(6*j-3,6*i-3) + k(9,3);
            K(6*j-3,6*i-2) = K(6*j-3,6*i-2) + k(9,4);
            K(6*j-3,6*i-1) = K(6*j-3,6*i-1) + k(9,5);
            K(6*j-3,6*i) = K(6*j-3,6*i) + k(9,6);
            K(6*j-3,6*j-5) = K(6*j-3,6*j-5) + k(9,7);
            K(6*j-3,6*j-4) = K(6*j-3,6*j-4) + k(9,8);
            K(6*j-3,6*j-3) = K(6*j-3,6*j-3) + k(9,9);
            K(6*j-3,6*j-2) = K(6*j-3,6*j-2) + k(9,10);
            K(6*j-3,6*j-1) = K(6*j-3,6*j-1) + k(9,11);
            K(6*j-3,6*j) = K(6*j-3,6*j) + k(9,12);
            K(6*j-2,6*i-5) = K(6*j-2,6*i-5) + k(10,1);
            K(6*j-2,6*i-4) = K(6*j-2,6*i-4) + k(10,2);
            K(6*j-2,6*i-3) = K(6*j-2,6*i-3) + k(10,3);
            K(6*j-2,6*i-2) = K(6*j-2,6*i-2) + k(10,4);
            K(6*j-2,6*i-1) = K(6*j-2,6*i-1) + k(10,5);
            K(6*j-2,6*i) = K(6*j-2,6*i) + k(10,6);
            K(6*j-2,6*j-5) = K(6*j-2,6*j-5) + k(10,7);
            K(6*j-2,6*j-4) = K(6*j-2,6*j-4) + k(10,8);
            K(6*j-2,6*j-3) = K(6*j-2,6*j-3) + k(10,9);
            K(6*j-2,6*j-2) = K(6*j-2,6*j-2) + k(10,10);
            K(6*j-2,6*j-1) = K(6*j-2,6*j-1) + k(10,11);
            K(6*j-2,6*j) = K(6*j-2,6*j) + k(10,12);
            K(6*j-1,6*i-5) = K(6*j-1,6*i-5) + k(11,1);
            K(6*j-1,6*i-4) = K(6*j-1,6*i-4) + k(11,2);
            K(6*j-1,6*i-3) = K(6*j-1,6*i-3) + k(11,3);
            K(6*j-1,6*i-2) = K(6*j-1,6*i-2) + k(11,4);
            K(6*j-1,6*i-1) = K(6*j-1,6*i-1) + k(11,5);
            K(6*j-1,6*i) = K(6*j-1,6*i) + k(11,6);
            K(6*j-1,6*j-5) = K(6*j-1,6*j-5) + k(11,7);
            K(6*j-1,6*j-4) = K(6*j-1,6*j-4) + k(11,8);
            K(6*j-1,6*j-3) = K(6*j-1,6*j-3) + k(11,9);
            K(6*j-1,6*j-2) = K(6*j-1,6*j-2) + k(11,10);
            K(6*j-1,6*j-1) = K(6*j-1,6*j-1) + k(11,11);
            K(6*j-1,6*j) = K(6*j-1,6*j) + k(11,12);
            K(6*j,6*i-5) = K(6*j,6*i-5) + k(12,1);
            K(6*j,6*i-4) = K(6*j,6*i-4) + k(12,2);
            K(6*j,6*i-3) = K(6*j,6*i-3) + k(12,3);
            K(6*j,6*i-2) = K(6*j,6*i-2) + k(12,4);
            K(6*j,6*i-1) = K(6*j,6*i-1) + k(12,5);
            K(6*j,6*i) = K(6*j,6*i) + k(12,6);
            K(6*j,6*j-5) = K(6*j,6*j-5) + k(12,7);
            K(6*j,6*j-4) = K(6*j,6*j-4) + k(12,8);
            K(6*j,6*j-3) = K(6*j,6*j-3) + k(12,9);
            K(6*j,6*j-2) = K(6*j,6*j-2) + k(12,10);
            K(6*j,6*j-1) = K(6*j,6*j-1) + k(12,11);
            K(6*j,6*j) = K(6*j,6*j) + k(12,12);
            y = K;
            end
        
            function [KB,FB] = BoundaryConditions(K,F,n)
            %BOUNDARYCONDITIONS Applies boundary conditions to GSM and GFV.
            %   This function uses the stored boundary condition flags from the node
            %   array 'n' to delete the appropriate rows of the GSM (global stiffness
            %   matrix) and GFV (global force vector).
            offset = 0;
            w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Applying boundary conditions');
            for i = 1:height(n)
                w.Value = i/height(n);
                for j = 1:6
                    if n(i,j+4) == 1
                        K(6*(i-1)+j-offset,:) = [];
                        K(:,6*(i-1)+j-offset) = [];
                        F(6*(i-1)+j-offset) = [];
                        offset = offset+1;
                    end
                end
            end
            close(w)
            KB = K;
            FB = F;
            end
        
            function [U,NF] = NodalDisplacements(K,KB,FB,n)
            %NODALDISPLACEMENTS Calculates nodal displacements for the space frame.
            %   This function calculates the nodal displacements for the unconstrained
            %   nodes using gaussian elimination. It then repackages the displacements
            %   to include the "zero displacements" for the constrained nodes. It also
            %   calculates the nodal forces using F = kx.
            u = KB\FB;
            U = zeros(height(n)*6,1);
            step = 0;
            w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Calculating nodal displacements');
            for i = 1:height(n)
                w.Value = i/height(n);
                for j =1:6
                    if n(i,j+4) == 1
                        U(6*(i-1)+j) = 0;
                    else
                        step = step+1;
                        U(6*(i-1)+j) = u(step);
                    end
                end
            end
            close(w)
            NF = K*U;
            end
        
            function [EF,sigx,My,Mz] = ElementInternalAnalysis(E,G,A,Iy,Iz,J,U,n,e)
            %ELEMENTINTERNALANALYSIS Calculates element stresses and bending moments.
            %  This function first compiles the element force vectors into an array,
            %  then it uses this array to calculate the axial stress in the elements.
            %  The element force array is reused to calculate the bending moment
            %  functions in y and z.
            EF = zeros(height(e),12);
            w = uiprogressdlg(app.UIFigure,'Title', ...
                    'Please wait...','Message','Analysing elements');
            for i = 1:height(e)
                w.Value = i/height(e);
                EF(i,:) = SpaceFrameElementForces(E,G,A,Iy,Iz,J,n(e(i,2),2), ...
                    n(e(i,2),3),n(e(i,2),4),n(e(i,3),2),n(e(i,3),3),n(e(i,3),4), ...
                    U([(6*(e(i,2)-1)+1:6*(e(i,2)-1)+6),(6*(e(i,3)-1)+1:6*(e(i,3)-1)+6)]));
            end
            close(w)
            sigx = zeros(height(e),1);
            for i = 1:height(e)
                sigx(i) = EF(i,7)/A;
            end
            sympref('FloatingPointOutput',true);
            syms x;
            My = sym(zeros(height(e),1));
            for i = 1:height(e)
                My(i) = EF(i,3)*x-EF(i,5);
            end
            Mz = sym(zeros(height(e),1));
            for i = 1:height(e)
                Mz(i) = EF(i,2)*x-EF(i,6);
            end
            end
        
            function [y] = SpaceFrameElementForces(E,G,A,Iy,Iz,J,x1,y1,z1,x2,y2,z2,u)
            %SpaceFrameElementForces   This function returns the element force
            %                          vector given the modulus of elasticity E,
            %                          the shear modulus of elasticity G, the 
            %                          cross-sectional area A, moments of inertia 
            %                          Iy and Iz, the torsional constant J, 
            %                          the coordinates (x1,y1,z1) of the first 
            %                          node, the coordinates (x2,y2,z2) of the
            %                          second node, and the element nodal 
            %                          displacement vector u.
            L = sqrt((x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1));
            w1 = E*A/L;
            w2 = 12*E*Iz/(L*L*L);
            w3 = 6*E*Iz/(L*L);
            w4 = 4*E*Iz/L;
            w5 = 2*E*Iz/L;
            w6 = 12*E*Iy/(L*L*L);
            w7 = 6*E*Iy/(L*L);
            w8 = 4*E*Iy/L;
            w9 = 2*E*Iy/L;
            w10 = G*J/L;
            kprime = [w1 0 0 0 0 0 -w1 0 0 0 0 0 ;
               0 w2 0 0 0 w3 0 -w2 0 0 0 w3 ;
               0 0 w6 0 -w7 0 0 0 -w6 0 -w7 0 ;
               0 0 0 w10 0 0 0 0 0 -w10 0 0 ;
               0 0 -w7 0 w8 0 0 0 w7 0 w9 0 ;
               0 w3 0 0 0 w4 0 -w3 0 0 0 w5 ;
               -w1 0 0 0 0 0 w1 0 0 0 0 0 ;
               0 -w2 0 0 0 -w3 0 w2 0 0 0 -w3 ;
               0 0 -w6 0 w7 0 0 0 w6 0 w7 0 ;
               0 0 0 -w10 0 0 0 0 0 w10 0 0 ;
               0 0 -w7 0 w9 0 0 0 w7 0 w8 0 ;
               0 w3 0 0 0 w5 0 -w3 0 0 0 w4];
            if x1 == x2 & y1 == y2
               if z2 > z1
                  Lambda = [0 0 1 ; 0 1 0 ; -1 0 0];
               else
                  Lambda = [0 0 -1 ; 0 1 0 ; 1 0 0];
               end
            else
               CXx = (x2-x1)/L;
            	CYx = (y2-y1)/L;
            	CZx = (z2-z1)/L;
            	D = sqrt(CXx*CXx + CYx*CYx);
            	CXy = -CYx/D;
	            CYy = CXx/D;
	            CZy = 0;
            	CXz = -CXx*CZx/D;
            	CYz = -CYx*CZx/D;
            	CZz = D;
            	Lambda = [CXx CYx CZx ; CXy CYy CZy ; CXz CYz CZz];
            end
            R = [Lambda zeros(3) zeros(3) zeros(3) ; 
               zeros(3) Lambda zeros(3) zeros(3) ;
               zeros(3) zeros(3) Lambda zeros(3) ;
               zeros(3) zeros(3) zeros(3) Lambda];
            y = kprime*R* u;
            end
        end
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            close all
            clc

            % Formatting how data is displayed
            app.Nodes.ColumnFormat = {'short'};
            
            % Init checkers
            app.SNLoaded = 0;
            app.FEASolved = 0;
            app.SurfaceSolved = 0;

            % Toolbar
            app.ClearBar.Icon = fullfile(matlabroot,'toolbox','matlab', ...
                'icons','file_new.png');
            app.ClearBar.Tooltip = 'New Space Frame';
            app.SaveBar.Icon = fullfile(matlabroot,'toolbox','matlab', ...
                'icons','file_save.png');
            app.SaveBar.Tooltip = 'Save Space Frame';
            app.LoadBar.Icon = fullfile(matlabroot,'toolbox','matlab', ...
                'icons','file_open.png');
            app.LoadBar.Tooltip = 'Load Space Frame';
            app.ImportBar.Icon = fullfile(matlabroot,'toolbox','matlab', ...
                'icons','file_open.png');
            app.ImportBar.Tooltip = 'Import Nodes';
        end

        % Button pushed function: Analyse
        function AnalysePushed(app, event)
            FEMSolver(app);
        end

        % Value changed function: NodeNumber
        function NodeNumberValueChanged(app, event)
            Update(app);
            if app.HighlightN.Value == 1
                SpaceFramePlot(app);
            end
        end

        % Button pushed function: AddNode
        function AddNodePushed(app, event)
            app.E = 3;
            Error = ErrorChecker(app);
            if Error == 0
                if app.NodeNumber.Value <= height(app.n)
                    msg = 'Would you like to overwrite this node?';
                    title = 'NODE ALREADY EXISTS';
                    selection = uiconfirm(app.UIFigure,msg,title,'Options', ...
                    {'Yes','No'},'DefaultOption','No','Icon','warning');
                    if contains(selection,'Yes')
                        AddNodeToArray(app)
                    end
                else
                    AddNodeToArray(app)
                end
            end
            Update(app);
            SpaceFramePlot(app);
        end

        % Button pushed function: RemoveNode
        function RemoveNodePushed(app, event)
            app.E = [1,4];
            Error = ErrorChecker(app);
            if Error == 0
                msg = 'Are you sure you want to delete this node?';
                title = 'CONFIRM DELETE';
                selection = uiconfirm(app.UIFigure,msg,title,'Options', ...
                {'Yes','No'},'DefaultOption','No','Icon','warning');
                if contains(selection,'Yes')
                    RemoveNodeFromArray(app)
                end
            end
            Update(app);
            SpaceFramePlot(app);
        end

        % Button pushed function: SortNodes
        function SortNodesPushed(app, event)
            app.E = 1;
            Error = ErrorChecker(app);
            if Error == 0
                app.n = sortrows(app.n,[2,3,4,5,6,7]);
                % Reconfigure elements to correctly display new node numbers.
                for i = 1:height(app.e)
                    app.e(i,2) = find(app.n(:,1) == app.e(i,2));
                    app.e(i,3) = find(app.n(:,1) == app.e(i,3));
                end
                app.n(:,1) = 1:height(app.n);
                Update(app);
                if app.HighlightN.Value == 1 || app.LabelsN.Value == 1
                    SpaceFramePlot(app);
                end
            end
        end

        % Button pushed function: NextNode
        function NextNodePushed(app, event)
            app.E = 1;
            Error = ErrorChecker(app);
            if Error == 0
                app.NodeNumber.Value = app.NodeNumber.Value+1;
                Update(app);
                if app.HighlightN.Value == 1
                    SpaceFramePlot(app);
                end
            end
        end

        % Button pushed function: PreviousNode
        function PreviousNodePushed(app, event)
            app.E = 1;
            Error = ErrorChecker(app);
            if Error == 0
                if app.NodeNumber.Value ~= 1
                    app.NodeNumber.Value = app.NodeNumber.Value-1;
                end
                Update(app);
                if app.HighlightN.Value == 1
                    SpaceFramePlot(app);
                end
            end
        end

        % Button pushed function: FirstNode
        function FirstNodeButtonPushed(app, event)
            app.E = 1;
            Error = ErrorChecker(app);
            if Error == 0
                app.NodeNumber.Value = min(app.n(:,1));
                Update(app);
                if app.HighlightN.Value == 1
                    SpaceFramePlot(app);
                end
            end
        end

        % Button pushed function: LastNode
        function LastNodeButtonPushed(app, event)
            app.E = 1;
            Error = ErrorChecker(app);
            if Error == 0
                app.NodeNumber.Value = max(app.n(:,1));
                Update(app);
                if app.HighlightN.Value == 1
                    SpaceFramePlot(app);
                end
            end
        end

        % Value changed function: ElementNumber
        function ElementNumberValueChanged(app, event)
            Update(app);
            if app.HighlightN.Value == 1
                SpaceFramePlot(app);
            end
        end

        % Button pushed function: AddElement
        function AddElementPushed(app, event)
            app.E = [1,5,7];
            Error = ErrorChecker(app);
            if Error == 0
                if app.ElementNumber.Value <= height(app.e)
                    msg = 'Would you like to overwrite this element?';
                    title = 'ELEMENT ALREADY EXISTS';
                    selection = uiconfirm(app.UIFigure,msg,title, ...
                        'Options',{'Yes','No'},'DefaultOption', ...
                        'No','Icon','warning');
                    if contains(selection,'Yes')
                        AddElementToArray(app);
                    end
                else
                    AddElementToArray(app);
                end
            end
            Update(app);
            SpaceFramePlot(app);
        end

        % Button pushed function: RemoveElement
        function RemoveElementPushed(app, event)
            app.E = [2,6];
            Error = ErrorChecker(app);
            if Error == 0
                msg = 'Are you sure you want to delete this element?';
                title = 'CONFIRM DELETE';
                selection = uiconfirm(app.UIFigure,msg,title,'Options', ...
                {'Yes','No'},'DefaultOption','No','Icon','warning');
                if contains(selection,'Yes')
                    RemoveElementFromArray(app);
                end
            end
            Update(app);
            SpaceFramePlot(app);
        end

        % Button pushed function: SortElements
        function SortElementsPushed(app, event)
            app.E = 2;
            Error = ErrorChecker(app);
            if Error == 0
                app.e(:,2:3) = sort(app.e(:,2:3),2);
                app.e = sortrows(app.e,[2,3]);
                app.e(:,1) = 1:height(app.e);
                Update(app);
                if app.HighlightN.Value == 1
                    SpaceFramePlot(app);
                end
            end
        end

        % Button pushed function: NextElement
        function NextElementPushed(app, event)
            app.E = 2;
            Error = ErrorChecker(app);
            if Error == 0
                app.ElementNumber.Value = app.ElementNumber.Value+1;
                Update(app);
                if app.HighlightN.Value == 1
                    SpaceFramePlot(app);
                end
            end
        end

        % Button pushed function: PreviousElement
        function PreviousElementPushed(app, event)
            app.E = 2;
            Error = ErrorChecker(app);
            if Error == 0
                if app.ElementNumber.Value ~= 1
                    app.ElementNumber.Value = app.ElementNumber.Value-1;
                end
                Update(app);
                if app.HighlightN.Value == 1
                    SpaceFramePlot(app);
                end
            end
        end

        % Button pushed function: FirstElement
        function FirstElementButtonPushed(app, event)
            app.E = 2;
            Error = ErrorChecker(app);
            if Error == 0
                app.ElementNumber.Value = min(app.e(:,1));
                Update(app);
                if app.HighlightN.Value == 1
                    SpaceFramePlot(app);
                end
            end
        end

        % Button pushed function: LastElement
        function LastElementButtonPushed(app, event)
            app.E = 2;
            Error = ErrorChecker(app);
            if Error == 0
                app.ElementNumber.Value = max(app.e(:,1));
                Update(app);
                if app.HighlightN.Value == 1
                    SpaceFramePlot(app);
                end
            end
        end

        % Clicked callback: ClearBar
        function ClearBarClicked(app, event)
            msg = 'Are you sure you want to clear?';
            title = 'CAUTION';
            selection = uiconfirm(app.UIFigure,msg,title,'Options', ...
                {'Yes','No'},'DefaultOption','No','Icon','warning');
            if contains(selection,'Yes')
                msg = 'Would you like to save first?';
                title = 'SAVE';
                selection = uiconfirm(app.UIFigure,msg,title,'Options', ...
                    {'Yes','No'},'DefaultOption','Yes','Icon', ...
                    'file_save.png');
                if contains(selection,'Yes')
                    SaveBarClicked(app);
                end
                Clear(app);
                Update(app);
                SpaceFramePlot(app);
            end
        end

        % Clicked callback: SaveBar
        function SaveBarClicked(app, event)
            filename = inputdlg({'Filename:'},'Save', [1 50]);
            app.savefile = append('Savefiles/',string(filename));
            if ~exist("Savefiles/",'dir')
                mkdir("Savefiles/");
            end
            if ~isempty(app.savefile)
                if exist(append(app.savefile,'.mat')) == 2
                    msg = 'Would you like to overwrite this file?';
                    title = 'FILE ALREADY EXISTS';
                    selection = uiconfirm(app.UIFigure,msg,title,'Options', ...
                    {'Yes','No'},'DefaultOption','No','Icon','warning');
                    if contains(selection,'Yes')
                        SaveData(app);
                    end
                else
                    SaveData(app);
                end
            end
        end

        % Clicked callback: LoadBar
        function LoadBarClicked(app, event)
            msg = 'Would you like to save first?';
            title = 'CAUTION';
            selection = uiconfirm(app.UIFigure,msg,title,'Options', ...
            {'Yes','No'},'DefaultOption','Yes','Icon','warning');
            if contains(selection,'Yes')
                SaveBarClicked(app);
            end
            LoadData(app);
            Update(app);
            SpaceFramePlot(app);
        end

        % Clicked callback: ImportBar
        function ImportBarClicked(app, event)
            msg = 'Would you like to save first?';
            title = 'CAUTION';
            selection = uiconfirm(app.UIFigure,msg,title,'Options', ...
            {'Yes','No'},'DefaultOption','Yes','Icon','warning');
            if contains(selection,'Yes')
                SaveBarClicked(app);
            end
            ImportData(app);
            Update(app);
            SpaceFramePlot(app);
        end

        % Value changed function: Plot
        function PlotValueChanged(app, event)
            if app.Plot.Value == 1
                figure(1)
                view(3)
                SpaceFramePlot(app);
            else
                SpaceFramePlot(app);
            end
        end

        % Value changed function: PlotFEA
        function PlotFEAValueChanged(app, event)
            if app.PlotFEA.Value == 1 && app.FEASolved == 1
                figure(2)
                view(3)
                FEAPlot(app);
            else
                FEAPlot(app);
            end
        end

        % Value changed function: PlotSurface
        function PlotSurfaceValueChanged(app, event)
            if app.PlotSurface.Value == 1 && app.SurfaceSolved == 1
                figure(3)
                SurfacePlot(app);
            else
                SurfacePlot(app);
            end
        end

        % Value changed function: ShowN
        function ShowNValueChanged(app, event)
            SpaceFramePlot(app);
        end

        % Value changed function: ShowE
        function ShowEValueChanged(app, event)
            SpaceFramePlot(app);
        end

        % Value changed function: LabelsN
        function LabelsNValueChanged(app, event)
            SpaceFramePlot(app);
        end

        % Value changed function: LabelsE
        function LabelsEValueChanged(app, event)
            SpaceFramePlot(app);
        end

        % Value changed function: HighlightN
        function HighlightNValueChanged(app, event)
            SpaceFramePlot(app);
        end

        % Value changed function: HighlightE
        function HighlightEValueChanged(app, event)
            SpaceFramePlot(app);
        end

        % Value changed function: Undeflected
        function UndeflectedValueChanged(app, event)
            FEAPlot(app);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Position = [100 100 960 960];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.Resize = 'off';

            % Create Toolbar
            app.Toolbar = uitoolbar(app.UIFigure);

            % Create ClearBar
            app.ClearBar = uipushtool(app.Toolbar);
            app.ClearBar.ClickedCallback = createCallbackFcn(app, @ClearBarClicked, true);

            % Create SaveBar
            app.SaveBar = uipushtool(app.Toolbar);
            app.SaveBar.ClickedCallback = createCallbackFcn(app, @SaveBarClicked, true);

            % Create LoadBar
            app.LoadBar = uipushtool(app.Toolbar);
            app.LoadBar.ClickedCallback = createCallbackFcn(app, @LoadBarClicked, true);

            % Create ImportBar
            app.ImportBar = uipushtool(app.Toolbar);
            app.ImportBar.ClickedCallback = createCallbackFcn(app, @ImportBarClicked, true);

            % Create MainGrid
            app.MainGrid = uigridlayout(app.UIFigure);
            app.MainGrid.ColumnWidth = {'100x', '70x', '90x'};
            app.MainGrid.RowHeight = {'60x', '30x', '20x', '35x', '100x'};
            app.MainGrid.ColumnSpacing = 6.5;
            app.MainGrid.RowSpacing = 3.1;
            app.MainGrid.Padding = [6.5 3.1 6.5 3.1];

            % Create NodesPanel
            app.NodesPanel = uipanel(app.MainGrid);
            app.NodesPanel.AutoResizeChildren = 'off';
            app.NodesPanel.Title = 'Nodes';
            app.NodesPanel.Layout.Row = [1 2];
            app.NodesPanel.Layout.Column = 1;

            % Create NodesGrid
            app.NodesGrid = uigridlayout(app.NodesPanel);
            app.NodesGrid.ColumnWidth = {'fit', 'fit', 'fit', 'fit', 'fit'};
            app.NodesGrid.RowHeight = {'fit', 'fit', 'fit', 'fit', 'fit', 'fit', 'fit', 'fit'};

            % Create NodeEditFieldLabel
            app.NodeEditFieldLabel = uilabel(app.NodesGrid);
            app.NodeEditFieldLabel.HorizontalAlignment = 'right';
            app.NodeEditFieldLabel.Layout.Row = 1;
            app.NodeEditFieldLabel.Layout.Column = 1;
            app.NodeEditFieldLabel.Text = 'Node';

            % Create NodeNumber
            app.NodeNumber = uieditfield(app.NodesGrid, 'numeric');
            app.NodeNumber.ValueChangedFcn = createCallbackFcn(app, @NodeNumberValueChanged, true);
            app.NodeNumber.Layout.Row = 1;
            app.NodeNumber.Layout.Column = 2;
            app.NodeNumber.Value = 1;

            % Create XLabel
            app.XLabel = uilabel(app.NodesGrid);
            app.XLabel.HorizontalAlignment = 'right';
            app.XLabel.Layout.Row = 3;
            app.XLabel.Layout.Column = 1;
            app.XLabel.Text = 'X';

            % Create X
            app.X = uieditfield(app.NodesGrid, 'numeric');
            app.X.Layout.Row = 3;
            app.X.Layout.Column = 2;

            % Create YLabel
            app.YLabel = uilabel(app.NodesGrid);
            app.YLabel.HorizontalAlignment = 'right';
            app.YLabel.Layout.Row = 4;
            app.YLabel.Layout.Column = 1;
            app.YLabel.Text = 'Y';

            % Create Y
            app.Y = uieditfield(app.NodesGrid, 'numeric');
            app.Y.Layout.Row = 4;
            app.Y.Layout.Column = 2;

            % Create Z
            app.Z = uieditfield(app.NodesGrid, 'numeric');
            app.Z.Layout.Row = 5;
            app.Z.Layout.Column = 2;

            % Create ZLabel
            app.ZLabel = uilabel(app.NodesGrid);
            app.ZLabel.HorizontalAlignment = 'right';
            app.ZLabel.Layout.Row = 5;
            app.ZLabel.Layout.Column = 1;
            app.ZLabel.Text = 'Z';

            % Create Fx
            app.Fx = uieditfield(app.NodesGrid, 'numeric');
            app.Fx.Layout.Row = 6;
            app.Fx.Layout.Column = 2;

            % Create FxLabel
            app.FxLabel = uilabel(app.NodesGrid);
            app.FxLabel.HorizontalAlignment = 'right';
            app.FxLabel.Layout.Row = 6;
            app.FxLabel.Layout.Column = 1;
            app.FxLabel.Text = 'Fx';

            % Create Fy
            app.Fy = uieditfield(app.NodesGrid, 'numeric');
            app.Fy.Layout.Row = 7;
            app.Fy.Layout.Column = 2;

            % Create FyLabel
            app.FyLabel = uilabel(app.NodesGrid);
            app.FyLabel.HorizontalAlignment = 'right';
            app.FyLabel.Layout.Row = 7;
            app.FyLabel.Layout.Column = 1;
            app.FyLabel.Text = 'Fy';

            % Create Fz
            app.Fz = uieditfield(app.NodesGrid, 'numeric');
            app.Fz.Layout.Row = 8;
            app.Fz.Layout.Column = 2;

            % Create FzLabel
            app.FzLabel = uilabel(app.NodesGrid);
            app.FzLabel.HorizontalAlignment = 'right';
            app.FzLabel.Layout.Row = 8;
            app.FzLabel.Layout.Column = 1;
            app.FzLabel.Text = 'Fz';

            % Create Fixedx
            app.Fixedx = uibutton(app.NodesGrid, 'state');
            app.Fixedx.Text = 'Fixed (x)';
            app.Fixedx.Layout.Row = 3;
            app.Fixedx.Layout.Column = 3;

            % Create Fixedy
            app.Fixedy = uibutton(app.NodesGrid, 'state');
            app.Fixedy.Text = 'Fixed (y)';
            app.Fixedy.Layout.Row = 4;
            app.Fixedy.Layout.Column = 3;

            % Create Fixedz
            app.Fixedz = uibutton(app.NodesGrid, 'state');
            app.Fixedz.Text = 'Fixed (z)';
            app.Fixedz.Layout.Row = 5;
            app.Fixedz.Layout.Column = 3;

            % Create FixedThetax
            app.FixedThetax = uibutton(app.NodesGrid, 'state');
            app.FixedThetax.Text = 'Fixed (Θx)';
            app.FixedThetax.Layout.Row = 6;
            app.FixedThetax.Layout.Column = 3;

            % Create FixedThetay
            app.FixedThetay = uibutton(app.NodesGrid, 'state');
            app.FixedThetay.Text = 'Fixed (Θy)';
            app.FixedThetay.Layout.Row = 7;
            app.FixedThetay.Layout.Column = 3;

            % Create FixedThetaz
            app.FixedThetaz = uibutton(app.NodesGrid, 'state');
            app.FixedThetaz.Text = 'Fixed (Θz)';
            app.FixedThetaz.Layout.Row = 8;
            app.FixedThetaz.Layout.Column = 3;

            % Create PreviousNode
            app.PreviousNode = uibutton(app.NodesGrid, 'push');
            app.PreviousNode.ButtonPushedFcn = createCallbackFcn(app, @PreviousNodePushed, true);
            app.PreviousNode.Layout.Row = 1;
            app.PreviousNode.Layout.Column = 3;
            app.PreviousNode.Text = 'Previous';

            % Create NextNode
            app.NextNode = uibutton(app.NodesGrid, 'push');
            app.NextNode.ButtonPushedFcn = createCallbackFcn(app, @NextNodePushed, true);
            app.NextNode.Layout.Row = 1;
            app.NextNode.Layout.Column = 4;
            app.NextNode.Text = 'Next';

            % Create LastNode
            app.LastNode = uibutton(app.NodesGrid, 'push');
            app.LastNode.ButtonPushedFcn = createCallbackFcn(app, @LastNodeButtonPushed, true);
            app.LastNode.Layout.Row = 2;
            app.LastNode.Layout.Column = 4;
            app.LastNode.Text = 'Last';

            % Create AddNode
            app.AddNode = uibutton(app.NodesGrid, 'push');
            app.AddNode.ButtonPushedFcn = createCallbackFcn(app, @AddNodePushed, true);
            app.AddNode.Layout.Row = 1;
            app.AddNode.Layout.Column = 5;
            app.AddNode.Text = 'Add';

            % Create RemoveNode
            app.RemoveNode = uibutton(app.NodesGrid, 'push');
            app.RemoveNode.ButtonPushedFcn = createCallbackFcn(app, @RemoveNodePushed, true);
            app.RemoveNode.Layout.Row = 2;
            app.RemoveNode.Layout.Column = 5;
            app.RemoveNode.Text = 'Remove';

            % Create SortNodes
            app.SortNodes = uibutton(app.NodesGrid, 'push');
            app.SortNodes.ButtonPushedFcn = createCallbackFcn(app, @SortNodesPushed, true);
            app.SortNodes.Layout.Row = 3;
            app.SortNodes.Layout.Column = 5;
            app.SortNodes.Text = 'Sort';

            % Create FirstNode
            app.FirstNode = uibutton(app.NodesGrid, 'push');
            app.FirstNode.ButtonPushedFcn = createCallbackFcn(app, @FirstNodeButtonPushed, true);
            app.FirstNode.Layout.Row = 2;
            app.FirstNode.Layout.Column = 3;
            app.FirstNode.Text = 'First';

            % Create ElementsPanel
            app.ElementsPanel = uipanel(app.MainGrid);
            app.ElementsPanel.AutoResizeChildren = 'off';
            app.ElementsPanel.Title = 'Elements';
            app.ElementsPanel.Layout.Row = [3 4];
            app.ElementsPanel.Layout.Column = 1;

            % Create ElementsGrid
            app.ElementsGrid = uigridlayout(app.ElementsPanel);
            app.ElementsGrid.ColumnWidth = {'fit', 'fit', 'fit', 'fit', 'fit'};
            app.ElementsGrid.RowHeight = {'fit', 'fit', 'fit', 'fit'};

            % Create ElementEditFieldLabel
            app.ElementEditFieldLabel = uilabel(app.ElementsGrid);
            app.ElementEditFieldLabel.HorizontalAlignment = 'right';
            app.ElementEditFieldLabel.Layout.Row = 1;
            app.ElementEditFieldLabel.Layout.Column = 1;
            app.ElementEditFieldLabel.Text = 'Element';

            % Create ElementNumber
            app.ElementNumber = uieditfield(app.ElementsGrid, 'numeric');
            app.ElementNumber.ValueChangedFcn = createCallbackFcn(app, @ElementNumberValueChanged, true);
            app.ElementNumber.Layout.Row = 1;
            app.ElementNumber.Layout.Column = 2;
            app.ElementNumber.Value = 1;

            % Create Node1EditFieldLabel
            app.Node1EditFieldLabel = uilabel(app.ElementsGrid);
            app.Node1EditFieldLabel.HorizontalAlignment = 'right';
            app.Node1EditFieldLabel.Layout.Row = 3;
            app.Node1EditFieldLabel.Layout.Column = 1;
            app.Node1EditFieldLabel.Text = 'Node 1';

            % Create Node1
            app.Node1 = uieditfield(app.ElementsGrid, 'numeric');
            app.Node1.Layout.Row = 3;
            app.Node1.Layout.Column = 2;

            % Create Node2EditFieldLabel
            app.Node2EditFieldLabel = uilabel(app.ElementsGrid);
            app.Node2EditFieldLabel.HorizontalAlignment = 'right';
            app.Node2EditFieldLabel.Layout.Row = 4;
            app.Node2EditFieldLabel.Layout.Column = 1;
            app.Node2EditFieldLabel.Text = 'Node 2';

            % Create Node2
            app.Node2 = uieditfield(app.ElementsGrid, 'numeric');
            app.Node2.Layout.Row = 4;
            app.Node2.Layout.Column = 2;

            % Create PreviousElement
            app.PreviousElement = uibutton(app.ElementsGrid, 'push');
            app.PreviousElement.ButtonPushedFcn = createCallbackFcn(app, @PreviousElementPushed, true);
            app.PreviousElement.Layout.Row = 1;
            app.PreviousElement.Layout.Column = 3;
            app.PreviousElement.Text = 'Previous';

            % Create NextElement
            app.NextElement = uibutton(app.ElementsGrid, 'push');
            app.NextElement.ButtonPushedFcn = createCallbackFcn(app, @NextElementPushed, true);
            app.NextElement.Layout.Row = 1;
            app.NextElement.Layout.Column = 4;
            app.NextElement.Text = 'Next';

            % Create LastElement
            app.LastElement = uibutton(app.ElementsGrid, 'push');
            app.LastElement.ButtonPushedFcn = createCallbackFcn(app, @LastElementButtonPushed, true);
            app.LastElement.Layout.Row = 2;
            app.LastElement.Layout.Column = 4;
            app.LastElement.Text = 'Last';

            % Create AddElement
            app.AddElement = uibutton(app.ElementsGrid, 'push');
            app.AddElement.ButtonPushedFcn = createCallbackFcn(app, @AddElementPushed, true);
            app.AddElement.Layout.Row = 1;
            app.AddElement.Layout.Column = 5;
            app.AddElement.Text = 'Add';

            % Create RemoveElement
            app.RemoveElement = uibutton(app.ElementsGrid, 'push');
            app.RemoveElement.ButtonPushedFcn = createCallbackFcn(app, @RemoveElementPushed, true);
            app.RemoveElement.Layout.Row = 2;
            app.RemoveElement.Layout.Column = 5;
            app.RemoveElement.Text = 'Remove';

            % Create SortElements
            app.SortElements = uibutton(app.ElementsGrid, 'push');
            app.SortElements.ButtonPushedFcn = createCallbackFcn(app, @SortElementsPushed, true);
            app.SortElements.Layout.Row = 3;
            app.SortElements.Layout.Column = 5;
            app.SortElements.Text = 'Sort';

            % Create FirstElement
            app.FirstElement = uibutton(app.ElementsGrid, 'push');
            app.FirstElement.ButtonPushedFcn = createCallbackFcn(app, @FirstElementButtonPushed, true);
            app.FirstElement.Layout.Row = 2;
            app.FirstElement.Layout.Column = 3;
            app.FirstElement.Text = 'First';

            % Create ElementPropertiesPanel
            app.ElementPropertiesPanel = uipanel(app.MainGrid);
            app.ElementPropertiesPanel.AutoResizeChildren = 'off';
            app.ElementPropertiesPanel.Title = 'Element Properties';
            app.ElementPropertiesPanel.Layout.Row = 1;
            app.ElementPropertiesPanel.Layout.Column = 3;

            % Create ElementPropertiesGrid
            app.ElementPropertiesGrid = uigridlayout(app.ElementPropertiesPanel);
            app.ElementPropertiesGrid.RowHeight = {'fit', 'fit', 'fit', 'fit', 'fit', 'fit'};

            % Create EYoungsModulusLabel
            app.EYoungsModulusLabel = uilabel(app.ElementPropertiesGrid);
            app.EYoungsModulusLabel.HorizontalAlignment = 'right';
            app.EYoungsModulusLabel.Layout.Row = 2;
            app.EYoungsModulusLabel.Layout.Column = 1;
            app.EYoungsModulusLabel.Text = 'Young''s Modulus (GPa)';

            % Create ShearModulusGLabel
            app.ShearModulusGLabel = uilabel(app.ElementPropertiesGrid);
            app.ShearModulusGLabel.HorizontalAlignment = 'right';
            app.ShearModulusGLabel.Layout.Row = 3;
            app.ShearModulusGLabel.Layout.Column = 1;
            app.ShearModulusGLabel.Text = 'Shear Modulus (GPa)';

            % Create TubeDiameterDmLabel
            app.TubeDiameterDmLabel = uilabel(app.ElementPropertiesGrid);
            app.TubeDiameterDmLabel.HorizontalAlignment = 'right';
            app.TubeDiameterDmLabel.Layout.Row = 5;
            app.TubeDiameterDmLabel.Layout.Column = 1;
            app.TubeDiameterDmLabel.Text = 'Tube Diameter (mm)';

            % Create WallThicknessTLabel
            app.WallThicknessTLabel = uilabel(app.ElementPropertiesGrid);
            app.WallThicknessTLabel.HorizontalAlignment = 'right';
            app.WallThicknessTLabel.Layout.Row = 6;
            app.WallThicknessTLabel.Layout.Column = 1;
            app.WallThicknessTLabel.Text = 'Wall Thickness (mm)';

            % Create TElement
            app.TElement = uieditfield(app.ElementPropertiesGrid, 'numeric');
            app.TElement.Layout.Row = 6;
            app.TElement.Layout.Column = 2;

            % Create DElement
            app.DElement = uieditfield(app.ElementPropertiesGrid, 'numeric');
            app.DElement.Layout.Row = 5;
            app.DElement.Layout.Column = 2;

            % Create DensitykgmLabel
            app.DensitykgmLabel = uilabel(app.ElementPropertiesGrid);
            app.DensitykgmLabel.HorizontalAlignment = 'right';
            app.DensitykgmLabel.Layout.Row = 4;
            app.DensitykgmLabel.Layout.Column = 1;
            app.DensitykgmLabel.Text = 'Density (g/cm³)';

            % Create PElement
            app.PElement = uieditfield(app.ElementPropertiesGrid, 'numeric');
            app.PElement.Layout.Row = 4;
            app.PElement.Layout.Column = 2;

            % Create GElement
            app.GElement = uieditfield(app.ElementPropertiesGrid, 'numeric');
            app.GElement.Layout.Row = 3;
            app.GElement.Layout.Column = 2;

            % Create EElement
            app.EElement = uieditfield(app.ElementPropertiesGrid, 'numeric');
            app.EElement.Layout.Row = 2;
            app.EElement.Layout.Column = 2;

            % Create MaterialEditFieldLabel
            app.MaterialEditFieldLabel = uilabel(app.ElementPropertiesGrid);
            app.MaterialEditFieldLabel.HorizontalAlignment = 'right';
            app.MaterialEditFieldLabel.Layout.Row = 1;
            app.MaterialEditFieldLabel.Layout.Column = 1;
            app.MaterialEditFieldLabel.Text = 'Material';

            % Create MatElement
            app.MatElement = uieditfield(app.ElementPropertiesGrid, 'text');
            app.MatElement.Layout.Row = 1;
            app.MatElement.Layout.Column = 2;

            % Create PlotPanel
            app.PlotPanel = uipanel(app.MainGrid);
            app.PlotPanel.AutoResizeChildren = 'off';
            app.PlotPanel.Title = '3D Plot';
            app.PlotPanel.Layout.Row = 1;
            app.PlotPanel.Layout.Column = 2;

            % Create PlotGrid
            app.PlotGrid = uigridlayout(app.PlotPanel);
            app.PlotGrid.RowHeight = {'fit', 'fit', 'fit', 'fit', 'fit'};

            % Create Plot
            app.Plot = uibutton(app.PlotGrid, 'state');
            app.Plot.ValueChangedFcn = createCallbackFcn(app, @PlotValueChanged, true);
            app.Plot.Text = 'Plot';
            app.Plot.Layout.Row = 1;
            app.Plot.Layout.Column = 1;

            % Create LabelsN
            app.LabelsN = uibutton(app.PlotGrid, 'state');
            app.LabelsN.ValueChangedFcn = createCallbackFcn(app, @LabelsNValueChanged, true);
            app.LabelsN.Text = 'Node Labels';
            app.LabelsN.Layout.Row = 3;
            app.LabelsN.Layout.Column = 1;

            % Create HighlightN
            app.HighlightN = uibutton(app.PlotGrid, 'state');
            app.HighlightN.ValueChangedFcn = createCallbackFcn(app, @HighlightNValueChanged, true);
            app.HighlightN.Text = 'Highlight Node';
            app.HighlightN.Layout.Row = 4;
            app.HighlightN.Layout.Column = 1;

            % Create ShowN
            app.ShowN = uibutton(app.PlotGrid, 'state');
            app.ShowN.ValueChangedFcn = createCallbackFcn(app, @ShowNValueChanged, true);
            app.ShowN.Text = 'Show Nodes';
            app.ShowN.Layout.Row = 2;
            app.ShowN.Layout.Column = 1;

            % Create ShowE
            app.ShowE = uibutton(app.PlotGrid, 'state');
            app.ShowE.ValueChangedFcn = createCallbackFcn(app, @ShowEValueChanged, true);
            app.ShowE.Text = 'Show Elements';
            app.ShowE.Layout.Row = 2;
            app.ShowE.Layout.Column = 2;

            % Create LabelsE
            app.LabelsE = uibutton(app.PlotGrid, 'state');
            app.LabelsE.ValueChangedFcn = createCallbackFcn(app, @LabelsEValueChanged, true);
            app.LabelsE.Text = 'Element Labels';
            app.LabelsE.Layout.Row = 3;
            app.LabelsE.Layout.Column = 2;

            % Create HighlightE
            app.HighlightE = uibutton(app.PlotGrid, 'state');
            app.HighlightE.ValueChangedFcn = createCallbackFcn(app, @HighlightEValueChanged, true);
            app.HighlightE.Text = 'Highlight Element';
            app.HighlightE.Layout.Row = 4;
            app.HighlightE.Layout.Column = 2;

            % Create DeformScaleEditFieldLabel
            app.DeformScaleEditFieldLabel = uilabel(app.PlotGrid);
            app.DeformScaleEditFieldLabel.HorizontalAlignment = 'right';
            app.DeformScaleEditFieldLabel.Layout.Row = 5;
            app.DeformScaleEditFieldLabel.Layout.Column = 1;
            app.DeformScaleEditFieldLabel.Text = 'Deform Scale';

            % Create DeformScale
            app.DeformScale = uieditfield(app.PlotGrid, 'numeric');
            app.DeformScale.Layout.Row = 5;
            app.DeformScale.Layout.Column = 2;
            app.DeformScale.Value = 1;

            % Create ArrayTablesPanel
            app.ArrayTablesPanel = uipanel(app.MainGrid);
            app.ArrayTablesPanel.AutoResizeChildren = 'off';
            app.ArrayTablesPanel.Title = 'Array Tables';
            app.ArrayTablesPanel.Layout.Row = 5;
            app.ArrayTablesPanel.Layout.Column = [1 3];

            % Create TablesGrid
            app.TablesGrid = uigridlayout(app.ArrayTablesPanel);
            app.TablesGrid.ColumnWidth = {669, 244};
            app.TablesGrid.RowHeight = {'1x'};

            % Create Nodes
            app.Nodes = uitable(app.TablesGrid);
            app.Nodes.ColumnName = {'Node'; 'X'; 'Y'; 'Z'; '(x)'; '(y)'; '(z)'; '(Θx)'; '(Θy)'; '(Θz)'; 'Fx'; 'Fy'; 'Fz'};
            app.Nodes.ColumnWidth = {50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50};
            app.Nodes.RowName = {};
            app.Nodes.Multiselect = 'off';
            app.Nodes.Layout.Row = 1;
            app.Nodes.Layout.Column = 1;

            % Create Elements
            app.Elements = uitable(app.TablesGrid);
            app.Elements.ColumnName = {'Element'; 'Node 1'; 'Node 2'};
            app.Elements.ColumnWidth = {75, 75, 75};
            app.Elements.RowName = {};
            app.Elements.Layout.Row = 1;
            app.Elements.Layout.Column = 2;

            % Create SurfacePropertiesPanel
            app.SurfacePropertiesPanel = uipanel(app.MainGrid);
            app.SurfacePropertiesPanel.AutoResizeChildren = 'off';
            app.SurfacePropertiesPanel.Title = 'Surface Properties';
            app.SurfacePropertiesPanel.Layout.Row = [2 3];
            app.SurfacePropertiesPanel.Layout.Column = 3;

            % Create SurfacePropertiesGrid
            app.SurfacePropertiesGrid = uigridlayout(app.SurfacePropertiesPanel);
            app.SurfacePropertiesGrid.RowHeight = {'fit', 'fit', 'fit', 'fit', 'fit'};

            % Create MaterialEditFieldLabel_2
            app.MaterialEditFieldLabel_2 = uilabel(app.SurfacePropertiesGrid);
            app.MaterialEditFieldLabel_2.HorizontalAlignment = 'right';
            app.MaterialEditFieldLabel_2.Layout.Row = 1;
            app.MaterialEditFieldLabel_2.Layout.Column = 1;
            app.MaterialEditFieldLabel_2.Text = 'Material';

            % Create PoissonsRatioLabel
            app.PoissonsRatioLabel = uilabel(app.SurfacePropertiesGrid);
            app.PoissonsRatioLabel.HorizontalAlignment = 'right';
            app.PoissonsRatioLabel.Layout.Row = 4;
            app.PoissonsRatioLabel.Layout.Column = 1;
            app.PoissonsRatioLabel.Text = 'Poisson''s Ratio (ν)';

            % Create PSurface
            app.PSurface = uieditfield(app.SurfacePropertiesGrid, 'numeric');
            app.PSurface.Layout.Row = 5;
            app.PSurface.Layout.Column = 2;

            % Create NUSurface
            app.NUSurface = uieditfield(app.SurfacePropertiesGrid, 'numeric');
            app.NUSurface.Layout.Row = 4;
            app.NUSurface.Layout.Column = 2;

            % Create YoungsModulusEGPaLabel
            app.YoungsModulusEGPaLabel = uilabel(app.SurfacePropertiesGrid);
            app.YoungsModulusEGPaLabel.HorizontalAlignment = 'right';
            app.YoungsModulusEGPaLabel.Layout.Row = 3;
            app.YoungsModulusEGPaLabel.Layout.Column = 1;
            app.YoungsModulusEGPaLabel.Text = 'Young''s Modulus (GPa)';

            % Create ESurface
            app.ESurface = uieditfield(app.SurfacePropertiesGrid, 'numeric');
            app.ESurface.Layout.Row = 3;
            app.ESurface.Layout.Column = 2;

            % Create DensitygcmLabel
            app.DensitygcmLabel = uilabel(app.SurfacePropertiesGrid);
            app.DensitygcmLabel.HorizontalAlignment = 'right';
            app.DensitygcmLabel.Layout.Row = 5;
            app.DensitygcmLabel.Layout.Column = 1;
            app.DensitygcmLabel.Text = 'Density (g/cm³)';

            % Create DensityLabel
            app.DensityLabel = uilabel(app.SurfacePropertiesGrid);
            app.DensityLabel.HorizontalAlignment = 'right';
            app.DensityLabel.Layout.Row = 2;
            app.DensityLabel.Layout.Column = 1;
            app.DensityLabel.Text = 'Mass (kg)';

            % Create MassSurface
            app.MassSurface = uieditfield(app.SurfacePropertiesGrid, 'numeric');
            app.MassSurface.Layout.Row = 2;
            app.MassSurface.Layout.Column = 2;

            % Create MatSurface
            app.MatSurface = uieditfield(app.SurfacePropertiesGrid, 'text');
            app.MatSurface.Layout.Row = 1;
            app.MatSurface.Layout.Column = 2;

            % Create FEMSolverPanel
            app.FEMSolverPanel = uipanel(app.MainGrid);
            app.FEMSolverPanel.AutoResizeChildren = 'off';
            app.FEMSolverPanel.Title = 'FEM Solver';
            app.FEMSolverPanel.Layout.Row = [2 3];
            app.FEMSolverPanel.Layout.Column = 2;

            % Create FEMSolverGrid
            app.FEMSolverGrid = uigridlayout(app.FEMSolverPanel);
            app.FEMSolverGrid.RowHeight = {'fit', 'fit', 'fit', 'fit', 'fit'};

            % Create Analyse
            app.Analyse = uibutton(app.FEMSolverGrid, 'push');
            app.Analyse.ButtonPushedFcn = createCallbackFcn(app, @AnalysePushed, true);
            app.Analyse.Layout.Row = 3;
            app.Analyse.Layout.Column = 1;
            app.Analyse.Text = 'Analyse';

            % Create AccelerationgEditFieldLabel
            app.AccelerationgEditFieldLabel = uilabel(app.FEMSolverGrid);
            app.AccelerationgEditFieldLabel.HorizontalAlignment = 'right';
            app.AccelerationgEditFieldLabel.Layout.Row = 1;
            app.AccelerationgEditFieldLabel.Layout.Column = 1;
            app.AccelerationgEditFieldLabel.Text = 'Acceleration (g)';

            % Create Acceleration
            app.Acceleration = uieditfield(app.FEMSolverGrid, 'numeric');
            app.Acceleration.Layout.Row = 1;
            app.Acceleration.Layout.Column = 2;
            app.Acceleration.Value = 1;

            % Create MeshResolutionEditFieldLabel
            app.MeshResolutionEditFieldLabel = uilabel(app.FEMSolverGrid);
            app.MeshResolutionEditFieldLabel.HorizontalAlignment = 'right';
            app.MeshResolutionEditFieldLabel.Layout.Row = 2;
            app.MeshResolutionEditFieldLabel.Layout.Column = 1;
            app.MeshResolutionEditFieldLabel.Text = 'Mesh Resolution';

            % Create MeshResolution
            app.MeshResolution = uieditfield(app.FEMSolverGrid, 'numeric');
            app.MeshResolution.Layout.Row = 2;
            app.MeshResolution.Layout.Column = 2;
            app.MeshResolution.Value = 1;

            % Create Surface
            app.Surface = uibutton(app.FEMSolverGrid, 'state');
            app.Surface.Text = 'Surface';
            app.Surface.Layout.Row = 3;
            app.Surface.Layout.Column = 2;

            % Create PlotFEA
            app.PlotFEA = uibutton(app.FEMSolverGrid, 'state');
            app.PlotFEA.ValueChangedFcn = createCallbackFcn(app, @PlotFEAValueChanged, true);
            app.PlotFEA.Text = 'Plot FEA';
            app.PlotFEA.Layout.Row = 4;
            app.PlotFEA.Layout.Column = 1;

            % Create Undeflected
            app.Undeflected = uibutton(app.FEMSolverGrid, 'state');
            app.Undeflected.ValueChangedFcn = createCallbackFcn(app, @UndeflectedValueChanged, true);
            app.Undeflected.Text = 'Plot Frame';
            app.Undeflected.Layout.Row = 5;
            app.Undeflected.Layout.Column = 1;

            % Create PlotSurface
            app.PlotSurface = uibutton(app.FEMSolverGrid, 'state');
            app.PlotSurface.ValueChangedFcn = createCallbackFcn(app, @PlotSurfaceValueChanged, true);
            app.PlotSurface.Text = 'Plot Surface';
            app.PlotSurface.Layout.Row = 4;
            app.PlotSurface.Layout.Column = 2;

            % Create OutputsPanel
            app.OutputsPanel = uipanel(app.MainGrid);
            app.OutputsPanel.AutoResizeChildren = 'off';
            app.OutputsPanel.Title = 'Outputs';
            app.OutputsPanel.Layout.Row = 4;
            app.OutputsPanel.Layout.Column = [2 3];

            % Create OuputsGrid
            app.OuputsGrid = uigridlayout(app.OutputsPanel);
            app.OuputsGrid.ColumnWidth = {'fit', '0.8x', '1x', '0.8x'};
            app.OuputsGrid.RowHeight = {'fit', 'fit', 'fit'};

            % Create FrameMasskgLabel
            app.FrameMasskgLabel = uilabel(app.OuputsGrid);
            app.FrameMasskgLabel.HorizontalAlignment = 'right';
            app.FrameMasskgLabel.Layout.Row = 1;
            app.FrameMasskgLabel.Layout.Column = 1;
            app.FrameMasskgLabel.Text = 'Frame Mass (kg)';

            % Create FrameMass
            app.FrameMass = uieditfield(app.OuputsGrid, 'numeric');
            app.FrameMass.Editable = 'off';
            app.FrameMass.Layout.Row = 1;
            app.FrameMass.Layout.Column = 2;

            % Create MaxSurfaceLabel
            app.MaxSurfaceLabel = uilabel(app.OuputsGrid);
            app.MaxSurfaceLabel.HorizontalAlignment = 'right';
            app.MaxSurfaceLabel.Layout.Row = 2;
            app.MaxSurfaceLabel.Layout.Column = 3;
            app.MaxSurfaceLabel.Text = 'Max Surface Stress (MPa)';

            % Create SigmaMax
            app.SigmaMax = uieditfield(app.OuputsGrid, 'numeric');
            app.SigmaMax.Editable = 'off';
            app.SigmaMax.Layout.Row = 2;
            app.SigmaMax.Layout.Column = 4;

            % Create SurfaceThicknessmmEditFieldLabel
            app.SurfaceThicknessmmEditFieldLabel = uilabel(app.OuputsGrid);
            app.SurfaceThicknessmmEditFieldLabel.HorizontalAlignment = 'right';
            app.SurfaceThicknessmmEditFieldLabel.Layout.Row = 1;
            app.SurfaceThicknessmmEditFieldLabel.Layout.Column = 3;
            app.SurfaceThicknessmmEditFieldLabel.Text = 'Surface Thickness (mm)';

            % Create SurfaceThickness
            app.SurfaceThickness = uieditfield(app.OuputsGrid, 'numeric');
            app.SurfaceThickness.Editable = 'off';
            app.SurfaceThickness.Layout.Row = 1;
            app.SurfaceThickness.Layout.Column = 4;

            % Create MaxElementStressGLabel
            app.MaxElementStressGLabel = uilabel(app.OuputsGrid);
            app.MaxElementStressGLabel.HorizontalAlignment = 'right';
            app.MaxElementStressGLabel.Layout.Row = 2;
            app.MaxElementStressGLabel.Layout.Column = 1;
            app.MaxElementStressGLabel.Text = 'Max Element Stress (MPa)';

            % Create MaxVM
            app.MaxVM = uieditfield(app.OuputsGrid, 'numeric');
            app.MaxVM.Editable = 'off';
            app.MaxVM.Layout.Row = 2;
            app.MaxVM.Layout.Column = 2;

            % Create MaxNodalDeflectionmEditFieldLabel
            app.MaxNodalDeflectionmEditFieldLabel = uilabel(app.OuputsGrid);
            app.MaxNodalDeflectionmEditFieldLabel.HorizontalAlignment = 'right';
            app.MaxNodalDeflectionmEditFieldLabel.Layout.Row = 3;
            app.MaxNodalDeflectionmEditFieldLabel.Layout.Column = 1;
            app.MaxNodalDeflectionmEditFieldLabel.Text = 'Max Nodal Deflection (m)';

            % Create MaxDeflect
            app.MaxDeflect = uieditfield(app.OuputsGrid, 'numeric');
            app.MaxDeflect.Editable = 'off';
            app.MaxDeflect.Layout.Row = 3;
            app.MaxDeflect.Layout.Column = 2;

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = SpaceFrameDesigner

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create UIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.UIFigure)

                % Execute the startup function
                runStartupFcn(app, @startupFcn)
            else

                % Focus the running singleton app
                figure(runningApp.UIFigure)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end