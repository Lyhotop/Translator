externdef __imp_CallFunctionShim:PPROC
CallFunctionShim equ <__imp_CallFunctionShim>

externdef __imp_CloseCtrs:PPROC
CloseCtrs equ <__imp_CloseCtrs>

externdef __imp_ClrCreateManagedInstance:PPROC
ClrCreateManagedInstance equ <__imp_ClrCreateManagedInstance>

externdef __imp_CoEEShutDownCOM:PPROC
CoEEShutDownCOM equ <__imp_CoEEShutDownCOM>

externdef __imp_CoInitializeCor:PPROC
CoInitializeCor equ <__imp_CoInitializeCor>

externdef __imp_CoInitializeEE:PPROC
CoInitializeEE equ <__imp_CoInitializeEE>

externdef __imp_CoUninitializeCor:PPROC
CoUninitializeCor equ <__imp_CoUninitializeCor>

externdef __imp_CoUninitializeEE:PPROC
CoUninitializeEE equ <__imp_CoUninitializeEE>

externdef __imp_CollectCtrs:PPROC
CollectCtrs equ <__imp_CollectCtrs>

externdef __imp_CorBindToCurrentRuntime:PPROC
CorBindToCurrentRuntime equ <__imp_CorBindToCurrentRuntime>

externdef __imp_CorBindToRuntime:PPROC
CorBindToRuntime equ <__imp_CorBindToRuntime>

externdef __imp_CorBindToRuntimeByCfg:PPROC
CorBindToRuntimeByCfg equ <__imp_CorBindToRuntimeByCfg>

externdef __imp_CorBindToRuntimeByPath:PPROC
CorBindToRuntimeByPath equ <__imp_CorBindToRuntimeByPath>

externdef __imp_CorBindToRuntimeByPathEx:PPROC
CorBindToRuntimeByPathEx equ <__imp_CorBindToRuntimeByPathEx>

externdef __imp_CorBindToRuntimeEx:PPROC
CorBindToRuntimeEx equ <__imp_CorBindToRuntimeEx>

externdef __imp_CorBindToRuntimeHost:PPROC
CorBindToRuntimeHost equ <__imp_CorBindToRuntimeHost>

externdef __imp_CorDllMainWorker:PPROC
CorDllMainWorker equ <__imp_CorDllMainWorker>

externdef __imp_CorExitProcess:PPROC
CorExitProcess equ <__imp_CorExitProcess>

externdef __imp_CorGetSvc:PPROC
CorGetSvc equ <__imp_CorGetSvc>

externdef __imp_CorIsLatestSvc:PPROC
CorIsLatestSvc equ <__imp_CorIsLatestSvc>

externdef __imp_CorMarkThreadInThreadPool:PPROC
CorMarkThreadInThreadPool equ <__imp_CorMarkThreadInThreadPool>

externdef __imp_CorTickleSvc:PPROC
CorTickleSvc equ <__imp_CorTickleSvc>

externdef __imp_CreateConfigStream:PPROC
CreateConfigStream equ <__imp_CreateConfigStream>

externdef __imp_CreateDebuggingInterfaceFromVersion:PPROC
CreateDebuggingInterfaceFromVersion equ <__imp_CreateDebuggingInterfaceFromVersion>

externdef __imp_DllCanUnloadNow:PPROC
DllCanUnloadNow equ <__imp_DllCanUnloadNow>

externdef __imp_DllGetClassObject:PPROC
DllGetClassObject equ <__imp_DllGetClassObject>

externdef __imp_DllRegisterServer:PPROC
DllRegisterServer equ <__imp_DllRegisterServer>

externdef __imp_DllUnregisterServer:PPROC
DllUnregisterServer equ <__imp_DllUnregisterServer>

externdef __imp_EEDllGetClassObjectFromClass:PPROC
EEDllGetClassObjectFromClass equ <__imp_EEDllGetClassObjectFromClass>

externdef __imp_EEDllRegisterServer:PPROC
EEDllRegisterServer equ <__imp_EEDllRegisterServer>

externdef __imp_EEDllUnregisterServer:PPROC
EEDllUnregisterServer equ <__imp_EEDllUnregisterServer>

externdef __imp_GetAssemblyMDImport:PPROC
GetAssemblyMDImport equ <__imp_GetAssemblyMDImport>

externdef __imp_GetCORRequiredVersion:PPROC
GetCORRequiredVersion equ <__imp_GetCORRequiredVersion>

externdef __imp_GetCORRootDirectory:PPROC
GetCORRootDirectory equ <__imp_GetCORRootDirectory>

externdef __imp_GetCORSystemDirectory:PPROC
GetCORSystemDirectory equ <__imp_GetCORSystemDirectory>

externdef __imp_GetCORVersion:PPROC
GetCORVersion equ <__imp_GetCORVersion>

externdef __imp_GetCompileInfo:PPROC
GetCompileInfo equ <__imp_GetCompileInfo>

externdef __imp_GetFileVersion:PPROC
GetFileVersion equ <__imp_GetFileVersion>

externdef __imp_GetHashFromAssemblyFile:PPROC
GetHashFromAssemblyFile equ <__imp_GetHashFromAssemblyFile>

externdef __imp_GetHashFromAssemblyFileW:PPROC
GetHashFromAssemblyFileW equ <__imp_GetHashFromAssemblyFileW>
  IFDEF __UNICODE__
    GetHashFromAssemblyFile equ <__imp_GetHashFromAssemblyFileW>
  ENDIF

externdef __imp_GetHashFromBlob:PPROC
GetHashFromBlob equ <__imp_GetHashFromBlob>

externdef __imp_GetHashFromFile:PPROC
GetHashFromFile equ <__imp_GetHashFromFile>

externdef __imp_GetHashFromFileW:PPROC
GetHashFromFileW equ <__imp_GetHashFromFileW>
  IFDEF __UNICODE__
    GetHashFromFile equ <__imp_GetHashFromFileW>
  ENDIF

externdef __imp_GetHashFromHandle:PPROC
GetHashFromHandle equ <__imp_GetHashFromHandle>

externdef __imp_GetHostConfigurationFile:PPROC
GetHostConfigurationFile equ <__imp_GetHostConfigurationFile>

externdef __imp_GetMetaDataInternalInterface:PPROC
GetMetaDataInternalInterface equ <__imp_GetMetaDataInternalInterface>

externdef __imp_GetMetaDataInternalInterfaceFromPublic:PPROC
GetMetaDataInternalInterfaceFromPublic equ <__imp_GetMetaDataInternalInterfaceFromPublic>

externdef __imp_GetMetaDataPublicInterfaceFromInternal:PPROC
GetMetaDataPublicInterfaceFromInternal equ <__imp_GetMetaDataPublicInterfaceFromInternal>

externdef __imp_GetPermissionRequests:PPROC
GetPermissionRequests equ <__imp_GetPermissionRequests>

externdef __imp_GetPrivateContextsPerfCounters:PPROC
GetPrivateContextsPerfCounters equ <__imp_GetPrivateContextsPerfCounters>

externdef __imp_GetProcessExecutableHeap:PPROC
GetProcessExecutableHeap equ <__imp_GetProcessExecutableHeap>

externdef __imp_GetRealProcAddress:PPROC
GetRealProcAddress equ <__imp_GetRealProcAddress>

externdef __imp_GetRequestedRuntimeInfo:PPROC
GetRequestedRuntimeInfo equ <__imp_GetRequestedRuntimeInfo>

externdef __imp_GetRequestedRuntimeVersion:PPROC
GetRequestedRuntimeVersion equ <__imp_GetRequestedRuntimeVersion>

externdef __imp_GetRequestedRuntimeVersionForCLSID:PPROC
GetRequestedRuntimeVersionForCLSID equ <__imp_GetRequestedRuntimeVersionForCLSID>

externdef __imp_GetStartupFlags:PPROC
GetStartupFlags equ <__imp_GetStartupFlags>

externdef __imp_GetTargetForVTableEntry:PPROC
GetTargetForVTableEntry equ <__imp_GetTargetForVTableEntry>

externdef __imp_GetTokenForVTableEntry:PPROC
GetTokenForVTableEntry equ <__imp_GetTokenForVTableEntry>

externdef __imp_GetVersionFromProcess:PPROC
GetVersionFromProcess equ <__imp_GetVersionFromProcess>

externdef __imp_GetXMLElement:PPROC
GetXMLElement equ <__imp_GetXMLElement>

externdef __imp_GetXMLElementAttribute:PPROC
GetXMLElementAttribute equ <__imp_GetXMLElementAttribute>

externdef __imp_GetXMLObject:PPROC
GetXMLObject equ <__imp_GetXMLObject>

externdef __imp_IEE:PPROC
IEE equ <__imp_IEE>

externdef __imp_InitErrors:PPROC
InitErrors equ <__imp_InitErrors>

externdef __imp_InitSSAutoEnterThread:PPROC
InitSSAutoEnterThread equ <__imp_InitSSAutoEnterThread>

externdef __imp_LoadLibraryShim:PPROC
LoadLibraryShim equ <__imp_LoadLibraryShim>

externdef __imp_LoadLibraryWithPolicyShim:PPROC
LoadLibraryWithPolicyShim equ <__imp_LoadLibraryWithPolicyShim>

externdef __imp_LoadStringRC:PPROC
LoadStringRC equ <__imp_LoadStringRC>

externdef __imp_LoadStringRCEx:PPROC
LoadStringRCEx equ <__imp_LoadStringRCEx>

externdef __imp_LockClrVersion:PPROC
LockClrVersion equ <__imp_LockClrVersion>

externdef __imp_LogHelp_LogAssert:PPROC
LogHelp_LogAssert equ <__imp_LogHelp_LogAssert>

externdef __imp_LogHelp_NoGuiOnAssert:PPROC
LogHelp_NoGuiOnAssert equ <__imp_LogHelp_NoGuiOnAssert>

externdef __imp_LogHelp_TerminateOnAssert:PPROC
LogHelp_TerminateOnAssert equ <__imp_LogHelp_TerminateOnAssert>

externdef __imp_MetaDataGetDispenser:PPROC
MetaDataGetDispenser equ <__imp_MetaDataGetDispenser>

externdef __imp_ND_CopyObjDst:PPROC
ND_CopyObjDst equ <__imp_ND_CopyObjDst>

externdef __imp_ND_CopyObjSrc:PPROC
ND_CopyObjSrc equ <__imp_ND_CopyObjSrc>

externdef __imp_ND_RI2:PPROC
ND_RI2 equ <__imp_ND_RI2>

externdef __imp_ND_RI4:PPROC
ND_RI4 equ <__imp_ND_RI4>

externdef __imp_ND_RI8:PPROC
ND_RI8 equ <__imp_ND_RI8>

externdef __imp_ND_RU1:PPROC
ND_RU1 equ <__imp_ND_RU1>

externdef __imp_ND_WI2:PPROC
ND_WI2 equ <__imp_ND_WI2>

externdef __imp_ND_WI4:PPROC
ND_WI4 equ <__imp_ND_WI4>

externdef __imp_ND_WI8:PPROC
ND_WI8 equ <__imp_ND_WI8>

externdef __imp_ND_WU1:PPROC
ND_WU1 equ <__imp_ND_WU1>

externdef __imp_OpenCtrs:PPROC
OpenCtrs equ <__imp_OpenCtrs>

externdef __imp_PostError:PPROC
PostError equ <__imp_PostError>

externdef __imp_ReOpenMetaDataWithMemory:PPROC
ReOpenMetaDataWithMemory equ <__imp_ReOpenMetaDataWithMemory>

externdef __imp_ReOpenMetaDataWithMemoryEx:PPROC
ReOpenMetaDataWithMemoryEx equ <__imp_ReOpenMetaDataWithMemoryEx>

externdef __imp_RunDll32ShimW:PPROC
RunDll32ShimW equ <__imp_RunDll32ShimW>
  IFDEF __UNICODE__
    RunDll32Shim equ <__imp_RunDll32ShimW>
  ENDIF

externdef __imp_RuntimeOSHandle:PPROC
RuntimeOSHandle equ <__imp_RuntimeOSHandle>

externdef __imp_RuntimeOpenImage:PPROC
RuntimeOpenImage equ <__imp_RuntimeOpenImage>

externdef __imp_RuntimeReleaseHandle:PPROC
RuntimeReleaseHandle equ <__imp_RuntimeReleaseHandle>

externdef __imp_SetTargetForVTableEntry:PPROC
SetTargetForVTableEntry equ <__imp_SetTargetForVTableEntry>

externdef __imp_StrongNameCompareAssemblies:PPROC
StrongNameCompareAssemblies equ <__imp_StrongNameCompareAssemblies>

externdef __imp_StrongNameErrorInfo:PPROC
StrongNameErrorInfo equ <__imp_StrongNameErrorInfo>

externdef __imp_StrongNameFreeBuffer:PPROC
StrongNameFreeBuffer equ <__imp_StrongNameFreeBuffer>

externdef __imp_StrongNameGetBlob:PPROC
StrongNameGetBlob equ <__imp_StrongNameGetBlob>

externdef __imp_StrongNameGetBlobFromImage:PPROC
StrongNameGetBlobFromImage equ <__imp_StrongNameGetBlobFromImage>

externdef __imp_StrongNameGetPublicKey:PPROC
StrongNameGetPublicKey equ <__imp_StrongNameGetPublicKey>

externdef __imp_StrongNameHashSize:PPROC
StrongNameHashSize equ <__imp_StrongNameHashSize>

externdef __imp_StrongNameKeyDelete:PPROC
StrongNameKeyDelete equ <__imp_StrongNameKeyDelete>

externdef __imp_StrongNameKeyGen:PPROC
StrongNameKeyGen equ <__imp_StrongNameKeyGen>

externdef __imp_StrongNameKeyGenEx:PPROC
StrongNameKeyGenEx equ <__imp_StrongNameKeyGenEx>

externdef __imp_StrongNameKeyInstall:PPROC
StrongNameKeyInstall equ <__imp_StrongNameKeyInstall>

externdef __imp_StrongNameSignatureGeneration:PPROC
StrongNameSignatureGeneration equ <__imp_StrongNameSignatureGeneration>

externdef __imp_StrongNameSignatureGenerationEx:PPROC
StrongNameSignatureGenerationEx equ <__imp_StrongNameSignatureGenerationEx>

externdef __imp_StrongNameSignatureSize:PPROC
StrongNameSignatureSize equ <__imp_StrongNameSignatureSize>

externdef __imp_StrongNameSignatureVerification:PPROC
StrongNameSignatureVerification equ <__imp_StrongNameSignatureVerification>

externdef __imp_StrongNameSignatureVerificationEx:PPROC
StrongNameSignatureVerificationEx equ <__imp_StrongNameSignatureVerificationEx>

externdef __imp_StrongNameSignatureVerificationFromImage:PPROC
StrongNameSignatureVerificationFromImage equ <__imp_StrongNameSignatureVerificationFromImage>

externdef __imp_StrongNameTokenFromAssembly:PPROC
StrongNameTokenFromAssembly equ <__imp_StrongNameTokenFromAssembly>

externdef __imp_StrongNameTokenFromAssemblyEx:PPROC
StrongNameTokenFromAssemblyEx equ <__imp_StrongNameTokenFromAssemblyEx>

externdef __imp_StrongNameTokenFromPublicKey:PPROC
StrongNameTokenFromPublicKey equ <__imp_StrongNameTokenFromPublicKey>

externdef __imp_TranslateSecurityAttributes:PPROC
TranslateSecurityAttributes equ <__imp_TranslateSecurityAttributes>

externdef __imp_UpdateError:PPROC
UpdateError equ <__imp_UpdateError>

externdef __imp__CorDllMain:PPROC
_CorDllMain equ <__imp__CorDllMain>

externdef __imp__CorExeMain2:PPROC
_CorExeMain2 equ <__imp__CorExeMain2>

externdef __imp__CorExeMain:PPROC
_CorExeMain equ <__imp__CorExeMain>

externdef __imp__CorImageUnloading:PPROC
_CorImageUnloading equ <__imp__CorImageUnloading>

externdef __imp__CorValidateImage:PPROC
_CorValidateImage equ <__imp__CorValidateImage>