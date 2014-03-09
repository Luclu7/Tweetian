/*
    Copyright (C) 2012 Dickson Leong
    This file is part of Tweetian.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0
import "../Services/Twitter.js" as Twitter

AbstractDelegate {
    id: root
    height: contextMenu.visible ? root.contentHeight + contextMenu.height : root.contentHeight
    imageSource: model.isReceiveDM ? model.profileImageUrl : settings.userProfileImage

    ContextMenu {
        id: contextMenu

        MenuItem {
            id: deleteDMMenuItem
            text: qsTr("Delete DM")
            onClicked: remorse.execute(root, qsTr("Deleting DM"), function() {  Twitter.postDeleteDirectMsg(model.id, internal.deleteDMOnSuccess, internal.deleteDMOnFailure) })
        }
    }

    Item {
        anchors { left: parent.left; right: parent.right }
        height: userNameText.height

        Text {
            id: userNameText
            anchors.left: parent.left
            width: Math.min(implicitWidth, parent.width)
            font.pixelSize: constant.fontSizeMedium
            font.bold: true
            color: highlighted ? constant.colorHighlighted : constant.colorLight
            elide: Text.ElideRight
            text: model.isReceiveDM ? model.name : settings.userFullName
        }

        Text {
            anchors { left: userNameText.right; leftMargin: constant.paddingMedium; right: parent.right }
            font.pixelSize: constant.fontSizeSmall
            color: highlighted ? constant.colorHighlighted : constant.colorMid
            elide: Text.ElideRight
            text: "@" + (model.isReceiveDM ? model.screenName : settings.userScreenName)
        }
    }

    Text {
        anchors { left: parent.left; right: parent.right }
        font.pixelSize: constant.fontSizeMedium
        wrapMode: Text.Wrap
        color: highlighted ? constant.colorHighlighted : constant.colorLight
        textFormat: Text.RichText
        text: model.richText
        height: implicitHeight + Theme.paddingSmall
    }

    Text {
        id: tweetTime
        anchors.left: parent.left
        horizontalAlignment: Text.AlignRight
        font.pixelSize: constant.fontSizeSmall
        color: highlighted ? constant.colorHighlighted : constant.colorMid
        elide: Text.ElideRight
        text: timeDiff
    }

    onPressAndHold: if(!model.isReceiveDM) contextMenu.show(root)
}
