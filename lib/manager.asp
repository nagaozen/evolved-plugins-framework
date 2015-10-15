<%

' Class: PluginManager
'
' Evolved Plugin manager.
'
' About:
'
'     - Written by Fabio Zendhi Nagao <http://zend.lojcomm.com.br> @ Jun 2013
'
class PluginManager

    ' --[ Public section ]------------------------------------------------------

    public default function [new](byVal name, byVal path)
        Me.name = name

        if( isEmpty( Application(Me.name) ) ) then
            Application(Me.name) = loadTextFile(path)
        end if

        set [new] = Me
    end function

    public classType

    public classVersion

    public name

    public Listeners

    public controller

    public method

    public sub [set](byVal controller, byVal method)
        dim Plugins, Plugin, i

        Me.controller = controller
        Me.method = method

        set Plugins = JSON.parse( Application(Me.name) )
        for each i in Plugins.enumerate()
            set Plugin = Plugins.get(i)
            if( not isEmpty( Plugin.extends.get( controller ) ) ) then
                if( Application("environment") = "DEVELOPMENT" _
                 or isEmpty( Application( []( "Plugins.{0}", Plugin.id ) ) ) _
                ) then
                    Application( []( "Plugins.{0}", Plugin.id ) ) = mid( loadTextFile( Server.mapPath( []( "{0}/plugin.asp", Plugin.path ) ) ), 3 )
                end if
                executeGlobal( Application( []( "Plugins.{0}", Plugin.id ) ) )
                execute( []( "Listeners.set ""{0}"", new {0}", Plugin.id ) )
            end if
            set Plugin = nothing
        next
        set Plugins = nothing
    end sub

    public sub define(byRef Actors)
        dim context_id, key
        context_id = []( "{0}_{1}", array(controller, method) )
        for each key in Listeners.enumerate()
            Listeners.get(key).define context_id, Actors
        next
    end sub

    public sub bind(byRef Actors)
        dim context_id, key
        context_id = []( "{0}_{1}", array(controller, method) )
        for each key in Listeners.enumerate()
            Listeners.get(key).bind context_id, Actors
        next
    end sub

    public sub beforeAction(byRef Context)
        dim context_id, key
        context_id = []( "{0}_{1}", array(controller, method) )
        for each key in Listeners.enumerate()
            Listeners.get(key).beforeAction context_id, Context
        next
    end sub

    public sub afterAction(byRef Context)
        dim context_id, key
        context_id = []( "{0}_{1}", array(controller, method) )
        for each key in Listeners.enumerate()
            Listeners.get(key).afterAction context_id, Context
        next
    end sub

    ' --[ Private section ]-----------------------------------------------------

    private sub Class_initialize()
        classType    = typename(Me)
        classVersion = "1.0.0"

        set Listeners = [!]("{}")
    end sub

    private sub Class_terminate()
        set Listeners = nothing
    end sub

end class

%>
