externdef __imp_DisplayOptions:PPROC
DisplayOptions equ <__imp_DisplayOptions>

externdef __imp_DllCanUnloadNow:PPROC
DllCanUnloadNow equ <__imp_DllCanUnloadNow>

externdef __imp_DllGetClassObject:PPROC
DllGetClassObject equ <__imp_DllGetClassObject>

externdef __imp_DllRegisterServer:PPROC
DllRegisterServer equ <__imp_DllRegisterServer>

externdef __imp_DllUnregisterServer:PPROC
DllUnregisterServer equ <__imp_DllUnregisterServer>

externdef __imp_MobsyncGetClassObject:PPROC
MobsyncGetClassObject equ <__imp_MobsyncGetClassObject>

externdef __imp_RegGetHandlerRegistrationInfo:PPROC
RegGetHandlerRegistrationInfo equ <__imp_RegGetHandlerRegistrationInfo>

externdef __imp_RegGetHandlerTopLevelKey:PPROC
RegGetHandlerTopLevelKey equ <__imp_RegGetHandlerTopLevelKey>

externdef __imp_RegGetProgressDetailsState:PPROC
RegGetProgressDetailsState equ <__imp_RegGetProgressDetailsState>

externdef __imp_RegGetSchedConnectionName:PPROC
RegGetSchedConnectionName equ <__imp_RegGetSchedConnectionName>

externdef __imp_RegGetSchedSyncSettings:PPROC
RegGetSchedSyncSettings equ <__imp_RegGetSchedSyncSettings>

externdef __imp_RegGetSyncItemSettings:PPROC
RegGetSyncItemSettings equ <__imp_RegGetSyncItemSettings>

externdef __imp_RegGetSyncSettings:PPROC
RegGetSyncSettings equ <__imp_RegGetSyncSettings>

externdef __imp_RegQueryLoadHandlerOnEvent:PPROC
RegQueryLoadHandlerOnEvent equ <__imp_RegQueryLoadHandlerOnEvent>

externdef __imp_RegRemoveManualSyncSettings:PPROC
RegRemoveManualSyncSettings equ <__imp_RegRemoveManualSyncSettings>

externdef __imp_RegSchedHandlerItemsChecked:PPROC
RegSchedHandlerItemsChecked equ <__imp_RegSchedHandlerItemsChecked>

externdef __imp_RegSetProgressDetailsState:PPROC
RegSetProgressDetailsState equ <__imp_RegSetProgressDetailsState>

externdef __imp_RegSetSyncItemSettings:PPROC
RegSetSyncItemSettings equ <__imp_RegSetSyncItemSettings>

externdef __imp_RegSetUserDefaults:PPROC
RegSetUserDefaults equ <__imp_RegSetUserDefaults>

externdef __imp_RunDllRegister:PPROC
RunDllRegister equ <__imp_RunDllRegister>

externdef __imp_SyncMgrRasProc:PPROC
SyncMgrRasProc equ <__imp_SyncMgrRasProc>

externdef __imp_SyncMgrResolveConflictA:PPROC
SyncMgrResolveConflictA equ <__imp_SyncMgrResolveConflictA>
  IFNDEF __UNICODE__
    SyncMgrResolveConflict equ <__imp_SyncMgrResolveConflictA>
  ENDIF

externdef __imp_SyncMgrResolveConflictW:PPROC
SyncMgrResolveConflictW equ <__imp_SyncMgrResolveConflictW>
  IFDEF __UNICODE__
    SyncMgrResolveConflict equ <__imp_SyncMgrResolveConflictW>
  ENDIF
