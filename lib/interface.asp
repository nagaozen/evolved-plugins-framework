<%

' File: interface.asp
'
' Evolved Plugin interface definition.
'
' License:
'
' This file is part of ASP Xtreme Evolution.
' Copyright (C) 2007-2012 Fabio Zendhi Nagao
'
' ASP Xtreme Evolution is free software: you can redistribute it and/or modify
' it under the terms of the GNU Lesser General Public License as published by
' the Free Software Foundation, either version 3 of the License, or
' (at your option) any later version.
'
' ASP Xtreme Evolution is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
' GNU Lesser General Public License for more details.
'
' You should have received a copy of the GNU Lesser General Public License
' along with ASP Xtreme Evolution. If not, see <http://www.gnu.org/licenses/>.



' Class: Plugin_Interface
'
' Defines the common specifications required to implement a working plugin of
' Evolved Plug-in Framework.
'
' About:
'
'     - Written by Fabio Zendhi Nagao <http://zend.lojcomm.com.br> @ Jun 2013
'
class Plugin_Interface' extends Interface

    ' --[ Interface definition ]------------------------------------------------

    ' Subroutine: activate
    '
    ' Creates plugin infrastructure and populate with possible existing data.
    '
    public sub activate()
    end sub

    ' Subroutine: deactivate
    '
    ' Removes plugin infrastructure.
    '
    public sub deactivate()
    end sub

    ' Subroutine: define
    '
    ' Includes new Actors to the action.
    '
    public sub define(byVal method, byRef Actors)
    end sub

    ' Subroutine: bind
    '
    ' Assign new events between action Actors.
    '
    public sub bind(byVal method, byRef Actors)
    end sub

    ' Subroutine: beforeAction
    '
    ' Extends action, changes output, etc.
    '
    public sub beforeAction(byVal method, byRef Context)
    end sub

    ' Subroutine: afterAction
    '
    ' Extends action, changes output, etc.
    '
    public sub afterAction(byVal method, byRef Context)
    end sub

    ' Property: classType
    ' 
    ' Class type.
    ' 
    ' Contains:
    ' 
    '   (string) - type
    ' 
    public classType

    ' Property: classVersion
    ' 
    ' Class version.
    ' 
    ' Contains:
    ' 
    '   (float) - version
    ' 
    public classVersion

    ' --[ Inheritance ]---------------------------------------------------------
    public Parent

    public property set Implementation(I)
        set Parent.Implementation = I
    end property

    public property get Implementation
        set Implementation = Parent.Implementation
    end property

    public property get requireds
        requireds = Parent.requireds
    end property

    public function check()
        check = Parent.check()
    end function

    ' --[ Protected section ]---------------------------------------------------

    ' --[ Private section ]-----------------------------------------------------

    private sub Class_initialize()
        classType    = typename(Me)
        classVersion = "1.0.0.0"

        set Parent = new Interface
        Parent.requireds = array("activate","deactivate","define","bind","beforeAction","afterAction")
    end sub

    private sub Class_terminate()
        set Parent = nothing
    end sub

end class

%>
